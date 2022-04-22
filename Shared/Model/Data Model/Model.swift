import Foundation
import Combine
import AVFoundation
import SwiftUI

class Model: NSObject, ObservableObject, AVAudioPlayerDelegate {
	var audioRecorder: AVAudioRecorder!
	var audioPlayer: AVAudioPlayer!
	@Published var isRecording = false
	@Published var isPlaying = false
	@Published var recordings: [Recording] = []
	@AppStorage("usesICloud") var usesICloud = true
	@AppStorage("iCloudEnabled") var iCloudEnabled = false
	var documentsDirectory: URL!

	var currentlyPlayingURL: URL? {
		if isPlaying {
			return audioPlayer.url
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
				}
			} else {
				var newDay = CalendarDay(for: recording.calendarDate)
				newDay.diaryEntries.append(recording)
				days.append(newDay)
			} // end if
		} // end loop
		return days
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
		   AVSampleRateKey: 24000, // same as Apple VoiceMemos
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

		#if os(iOS)
		let recordingSession = AVAudioSession.sharedInstance()
		do {
			try recordingSession.setCategory(.playAndRecord)
			try recordingSession.setMode(.default)
			try recordingSession.setActive(true)
		} catch {
			print("Unable to set up recording session on iOS.")
print(error)
		} // do try catch
		#endif

		do {
audioRecorder = try AVAudioRecorder(url: filePath, settings: recordingSettings)
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
		audioRecorder!.stop()
		isRecording = false
		print("Recording stopped.")
		fetchAllRecordings()
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

		// empty the array so we don't end up with duplicates
		recordings.removeAll()

		let fileManager = FileManager.default
		let directory = recordingsDirectory()

		do {
		let directoryContents = try fileManager.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
			for url in directoryContents {
				print("Fetching \(url)")
	let recording = Recording(fileURL: url)
				recordings.append(recording)
				recordings.sort(by: { $0.calendarDate.compare($1.calendarDate) == .orderedAscending})
			}
		} catch {
			print("Unable to fetch recordings because unable to get the contents of the documents directory in the app's container.")
		} // end do try catch
	} // func

	func recordings(for date: Date) -> [Recording] {
		return recordings.filter( { $0.calendarDate.isOnTheSameDay(as: date)} )
	} // func

	func delete(_ recording: Recording) {
		let url = recording.fileURL
		delete(url)
		fetchAllRecordings()
	}

	func delete(_ urlsToDelete: [URL]) {
			for url in urlsToDelete {
				delete(url)
			} // loop
		fetchAllRecordings()
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
	}

	func importRecording(_ url: URL) throws {
		let fileName = url.lastPathComponent
		let destinationURL = recordingsDirectory().appendingPathComponent(fileName, isDirectory: false)
		let fileManager = FileManager.default
		do {
			try fileManager.copyItem(at: url, to: destinationURL)
		} catch {
			print("Unable to copy the imported item (\(url) to \(destinationURL).")
			print(error)
			throw error
		}
		fetchAllRecordings()
	} // func

	func startPlaying(_ audio: URL) {
		if isPlaying { stopPlaying() }

print("About to play \(audio).")

		#if os(iOS)
		let playbackSession = AVAudioSession.sharedInstance()
		do {
					try playbackSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
				} catch {
					print("Couldn't play over the device's loud speaker.")
				}
		#endif

		do {
					audioPlayer = try AVAudioPlayer(contentsOf: audio)
			audioPlayer.delegate = self
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

	func getICloudToken() -> (NSCoding & NSCopying & NSObjectProtocol)? {
		return FileManager.default.ubiquityIdentityToken
	}

	func isUserLoggedIntoIcloud() -> Bool {
return getICloudToken() != nil
	}

	override init() {
		super.init()
iCloudEnabled = isUserLoggedIntoIcloud()
		print("The user is \(iCloudEnabled ? "" : "not") signed into icloud.")
		setDocumentsDirectory()
		fetchAllRecordings()
	}
} // class

//  Model.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
