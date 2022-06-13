import Foundation
import Combine
import AVFoundation
import SwiftUI
import AudioToolbox

class Model: NSObject, ObservableObject, AVAudioPlayerDelegate {
	var audioRecorder: AVAudioRecorder!
	var audioPlayer: AVAudioPlayer!
	@Published var isRecording = false
	@Published var isPlaying = false
	@Published var recordings: [Recording] = []
	@AppStorage("usesICloud") var usesICloud = true
	@AppStorage("iCloudEnabled") var iCloudEnabled = false
	var documentsDirectory: URL!
	@AppStorage("diaryEntries") var diaryEntriesJSON = Data()

	var currentlyPlayingURL: URL? {
		if let player = audioPlayer {
			return player.url
		} else {
			return nil
		} // end if
	} // variable

	var recordingsByDay: [CalendarDay] {
		// this code might take too long to be in a computed property
		var days = [CalendarDay]()
		for recording in recordings {
			if days.contains(where: { recording.calendarDate.isOnTheSameDay(as: $0.date) }) {
// add it to the relevant element of days
				if let index = days.firstIndex(where: { recording.calendarDate.isOnTheSameDay(as: $0.date) }) {
					days[index].diaryEntries.append(recording)
					// sort diary entries chronologically
					days[index].diaryEntries.sort(by: { $0.calendarDate < $1.calendarDate })
				}
			} else {
				var newDay = CalendarDay(for: recording.calendarDate)
				newDay.diaryEntries.append(recording)
				days.append(newDay)
			} // end if
		} // end loop
		// sort chronologically
		return days.sorted(by: { $0.date < $1.date } )
	} // end var

	subscript(id: UUID) -> Recording? {
		get {
			return recordings.first(where: { $0.id == id })
		} set {
			if let newValue = newValue, let index = recordings.firstIndex(where: { $0.id == id }) { recordings[index] = newValue }
		} // end setter
	} // end subscript

	var recordingSettings = [
		AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
		   AVSampleRateKey: 48000, // Apple VoiceMemos is only 24000
		   AVNumberOfChannelsKey: 1,
		   AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
	   ]

	func startRecording() {
		if isRecording {
print("A recording is already in progress.")
return
		}

		print("Preparing to start recording.")
		let filePath = newFileURL()

		do {
audioRecorder = try AVAudioRecorder(url: filePath, settings: recordingSettings)
			// play system sound before recording starts so that sound not captured by recording
			AudioServicesPlaySystemSound(1113) // begin_record.caf
			// alternative for mac was: playSystemSound(named: "Funk", ofType: .aiff)
			// sound effect still captured on recording
			audioRecorder.record()
			DispatchQueue.main.async {
				self.isRecording = true
			}
			print("Recording started.")
		} catch {
			print("Could not start recording.")
			print(error)
		}
	} // func

	func stopRecording() {
		// should be safe to force unwrap audioRecorder as stopRecording can only be called if a recording has started
		let newFileURL = audioRecorder!.url
		audioRecorder!.stop()
		AudioServicesPlaySystemSound(1114) // end_record.caf
		// alternative for macOS: playSystemSound(named: "Bottle", ofType: .aiff)
		isRecording = false
		print("Recording stopped.")
save(newFileURL)
	} // func

	func startPlaying(_ audio: URL) {
		if isPlaying { stopPlaying() }

print("About to play \(audio).")

		do {
					audioPlayer = try AVAudioPlayer(contentsOf: audio)
			audioPlayer.delegate = self
			#if os(iOS)
			setupNotifications()
			#endif
					audioPlayer.play()
			DispatchQueue.main.async {
				self.isPlaying = true
			} // main queue
			print("Started playing \(audio).")
				} catch {
					print("Playback failed.")
				}
	} // func

	func pause() {
		print("Pausing playback.")
		if isPlaying { audioPlayer.pause() }
		DispatchQueue.main.async {
			self.isPlaying = false
		}
print("Playback paused.")
	}

	func resumePlayback() {
		if audioPlayer == nil { return }
print("About to resume playback.")
					audioPlayer.play()
			DispatchQueue.main.async {
				self.isPlaying = true
			} // main queue
			print("Resumed playback.")
	} // func

	func stopPlaying() {
		print("Stopping playback.")
		// UI logic should mean that the stop button can only be pressed if isPlaying
		// but let's make doubly sure
		// because if nothing has yet been played the audioPlayer will be nil
		if isPlaying { audioPlayer.stop() }
		DispatchQueue.main.async {
			self.isPlaying = false
		}
		print("Playback stopped.")
	} // func

	func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
			if flag {
				DispatchQueue.main.async {
					self.isPlaying = false
				} // main queue
			} // end if
		} // func

	/*
	func audioPlayerBeginInterruption(_ player: AVAudioPlayer) {
		// depricated since iOS 8
		DispatchQueue.main.async {
			self.isPlaying = false
		} // end if
print("System interupted playback.")
	}
	 */

	// playing and recording audio requires additional configuration on iOS
	#if os(iOS)
	func configureAudioSession() {
let session = AVAudioSession.sharedInstance()
do {
	try session.setCategory(.playAndRecord, options: [.defaultToSpeaker, .allowBluetooth, .allowAirPlay, .allowBluetoothA2DP])
	try session.setMode(.default)
print("Audio session configured.")
} catch {
	print("Unable to set up audio session on iOS.")
print(error)
	fatalError("Unable to configure audio session on iOS.")
} // do try catch
	} // func

	func configureRecordingSession() {
let recordingSession = AVAudioSession.sharedInstance()
do {
	try recordingSession.setActive(true)
	print("Recording session configured.")
} catch {
	print("Unable to activate recording session on iOS.")
print(error)
} // do try catch
	}

	func setupNotifications() {
		// Get the default notification center instance.
		let nc = NotificationCenter.default
		nc.addObserver(self,
					   selector: #selector(handleInterruption),
					   name: AVAudioSession.interruptionNotification,
					   object: AVAudioSession.sharedInstance())
	}

	@objc func handleInterruption(notification: Notification) {
		guard let userInfo = notification.userInfo,
			let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
			let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
				return
		}

		// Switch over the interruption type.
		switch type {
		case .began:
			// An interruption began. Update the UI as necessary.
			DispatchQueue.main.async {
				self.isPlaying = false
			} // end if
	print("System interupted playback.")
		case .ended:
		   // An interruption ended. Resume playback, if appropriate.
			guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
			let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
			if options.contains(.shouldResume) {
				// An interruption ended. Resume playback.
// need method to resume playback
			} else {
				// An interruption ended. Don't resume playback.
			}
		default: ()
		}
	}
	#endif

	func playSystemSound(named soundName: String, ofType fileType: UTType) {
		if let soundID = idForSystemSound(named: soundName, ofType: fileType) {
AudioServicesPlaySystemSound(soundID)
			print("Sound played.")
		} else {
			print("Could not get valid SystemSoundID to play.")
		}
	}

	func idForSystemSound(named soundName: String, ofType fileType: UTType) -> SystemSoundID? {
		var soundID: SystemSoundID = 0 // 1013 = recording_started, 1014 = recording_stopped
		guard let url = urlForSystemSound(named: soundName, ofType: fileType) else {
			return nil
		}
		let cfURL = url as CFURL
AudioServicesCreateSystemSoundID(cfURL, &soundID)
return soundID
	} // func

	func urlForSystemSound(named soundName: String, ofType fileType: UTType) -> URL? {
		let fileManager = FileManager.default
		do {
		let library = try fileManager.url(for: .libraryDirectory, in: .systemDomainMask, appropriateFor: nil, create: false)
			let soundsDirectory = library.appendingPathComponent("Sounds", isDirectory: true)
			let soundURL = soundsDirectory.appendingPathComponent(soundName)
			return soundURL.appendingPathExtension(for: fileType)
		} catch {
			print("Could not get url for System Library directory.")
			print(error)
return nil
		}
	} // func

	func newFileURL() -> URL {
		let fileName = "Diary Entry"
		let fileExtension = ".m4a"
		let iso8601Date = Date().ISO8601Format(.init(dateSeparator: .dash, dateTimeSeparator: .space, timeSeparator: .omitted, timeZoneSeparator: .omitted, includingFractionalSeconds: false, timeZone: .autoupdatingCurrent))
		let index = iso8601Date.firstIndex(of: "+") ?? iso8601Date.endIndex
		let dateTimeStamp = iso8601Date[..<index]
		let dateStamp = dateTimeStamp.components(separatedBy: .whitespaces)[0]
		let timeStamp = dateTimeStamp.components(separatedBy: .whitespaces)[1]
		let documentPath = recordingsDirectory()
		let filePath = documentPath.appendingPathComponent("\(dateStamp) \(fileName) at \(timeStamp)\(fileExtension)")
		print("The file URL is \(filePath).")
		return filePath
	}

	func setDocumentsDirectory() {
		let fileManager = FileManager.default
		if iCloudEnabled && usesICloud {
			print("The user is signed into iCloud and has chosen to use it.")
			if let url = fileManager.url(forUbiquityContainerIdentifier: nil) {
				documentsDirectory = url.appendingPathComponent("Documents", isDirectory: true)
			} else {
print("fileManager.url(forUbiquityContainerIdentifier:) returned nil.")
				// should probably throw error or something
				documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
			} // end if we could get the ubiquity container url
		} else { // doesn't use iCloud
			print("iCloud is not enabled or the user has chosen not to use it.")
			documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
		} // end if
	} // func

	func recordingsDirectory() -> URL {
		let subDirectory = documentsDirectory.appendingPathComponent("Diary Entries", isDirectory: true)
		var isDirectory: ObjCBool = true
		let fileManager = FileManager.default
		if !fileManager.fileExists(atPath: subDirectory.path, isDirectory: &isDirectory) {
			do {
				try fileManager.createDirectory(at: subDirectory, withIntermediateDirectories: true)
			} catch {
				print("Unable to create Diary Entries directory.")
print(error)
				//TODO: Work out what to do if unable to create the subdirectory.
			} // end do try catch
		} // end if
		return subDirectory
	} // func

	func fetchAllRecordings() {
		print("Fetching recordings.")
		let fileManager = FileManager.default
		let directory = recordingsDirectory()
		var needToSave = false

		do {
		let directoryContents = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
			for url in directoryContents {
				if !recordings.contains(where: { $0.fileURL == url }) {
				print("Fetching \(url)")
	let recording = Recording(fileURL: url)
				recordings.append(recording)
				recordings.sort(by: { $0.calendarDate.compare($1.calendarDate) == .orderedAscending})
					needToSave = true
				} // end if
			} // end loop
		} catch {
			print("Unable to fetch recordings because unable to get the contents of the documents directory in the app's container.")
		} // end do try catch
		if needToSave { encodeDiaryEntriesToJSON() }
	} // func

	func recordings(for date: Date) -> [Recording] {
		return recordings.filter( { $0.calendarDate.isOnTheSameDay(as: date)} ).sorted(by: { $0.calendarDate < $1.calendarDate })
	} // func

	func delete(_ recording: Recording) {
		let url = recording.fileURL
		delete(url)
encodeDiaryEntriesToJSON()
	}

	func delete(_ urlsToDelete: [URL]) {
			for url in urlsToDelete {
				delete(url)
			} // loop
encodeDiaryEntriesToJSON()
	} // func

	func delete(_ url: URL) {
		print("Deleting \(url).")
		do {
		   try FileManager.default.trashItem(at: url, resultingItemURL: nil)
			print("File deleted.")
			if isPlaying && audioPlayer.url == url { self.stopPlaying() }
		} catch {
			print("Could not delete \(url). The error was: \(error.localizedDescription)")
		} // do try catch
		recordings.removeAll(where: { $0.fileURL == url } )
		print("Recording removed from recordings array.")
	}

	func importRecording(_ url: URL) throws {
		let fileName = url.lastPathComponent
		let destinationURL = recordingsDirectory().appendingPathComponent(fileName, isDirectory: false)
		let fileManager = FileManager.default
		do {
			let didAccess = url.startAccessingSecurityScopedResource()
			try fileManager.copyItem(at: url, to: destinationURL)
			if didAccess { url.stopAccessingSecurityScopedResource() }
		} catch {
			print("Unable to copy the imported item (\(url) to \(destinationURL).")
			print(error)
			throw error
		}
		save(destinationURL)
	} // func

	func getICloudToken() -> (NSCoding & NSCopying & NSObjectProtocol)? {
		return FileManager.default.ubiquityIdentityToken
	}

	func isUserLoggedIntoIcloud() -> Bool {
return getICloudToken() != nil
	}

	func decodeDiaryEntriesFromJSON() {
let decoder = JSONDecoder()
		decoder.dateDecodingStrategy = .iso8601
		print("About to decode diary entries from JSON.")
		do {
			recordings = try decoder.decode([Recording].self, from: diaryEntriesJSON)
			print("Diary entries decoded.")
		} catch {
			print("Error decoding diary entries from JSON. The error message was: \(error.localizedDescription).")
			fetchAllRecordings()
		}
	}

	func encodeDiaryEntriesToJSON() {
let encoder = JSONEncoder()
		encoder.outputFormatting = .prettyPrinted
		encoder.dateEncodingStrategy = .iso8601

		print("About to encode diary entry recordings to JSON.")
		var jsonData: Data
		do {
			jsonData = try encoder.encode(recordings)
		} catch {
			print("Error encoding diary entry recordings to JSON. The error message was: \(error.localizedDescription)")
			return
		}

		diaryEntriesJSON = jsonData
		print("Diary entry recordings saved as JSON.")
	}

	func save(_ url: URL) {
print("Saving \(url).")
let newDiaryEntry = Recording(fileURL: url)
		recordings.append(newDiaryEntry)
		recordings.sort(by: { $0.calendarDate < $1.calendarDate } )
		encodeDiaryEntriesToJSON()
		print("New diary entry recording saved.")
	}

	override init() {
		super.init()
iCloudEnabled = isUserLoggedIntoIcloud()
		print("The user is \(iCloudEnabled ? "" : "not") signed into icloud.")
		setDocumentsDirectory()
decodeDiaryEntriesFromJSON()
		fetchAllRecordings()
		#if os(iOS)
		configureAudioSession()
		configureRecordingSession()
		#endif
	}
} // class

//  Model.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
