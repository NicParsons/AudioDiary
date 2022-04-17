import Foundation
import Combine
import AVFoundation

class AudioRecorder: NSObject, ObservableObject {
	var audioRecorder: AVAudioRecorder!
	@Published var recording = false
	@Published var recordings: [Recording] = []

	var recordingSettings = [
		AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
		   AVSampleRateKey: 12000,
		   AVNumberOfChannelsKey: 1,
		   AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
	   ]

	func startRecording() {
		if recording == true {
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
				self.recording = true
			}
			print("Recording started.")
		} catch {
			print("Could not start recording.")
			print(error)
		}
	} // func

	func stopRecording() {
		audioRecorder!.stop()
		recording = false
		print("Recording stopped.")
		fetchRecordings()
	} // func

	func newFileURL() -> URL {
		let fileName = "diary entry"
		let fileExtension = ".m4a"
		let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
		let iso8601Date = Date().ISO8601Format(.init(dateSeparator: .dash, dateTimeSeparator: .space, timeSeparator: .omitted, timeZoneSeparator: .omitted, includingFractionalSeconds: false, timeZone: .autoupdatingCurrent))
		let dateTimeStamp = iso8601Date.substring(to: iso8601Date.firstIndex(of: "+") ?? iso8601Date.endIndex)
		let dateStamp = dateTimeStamp.components(separatedBy: .whitespaces)[0]
		let timeStamp = dateTimeStamp.components(separatedBy: .whitespaces)[1]
		let filePath = documentPath.appendingPathComponent("\(dateStamp) \(fileName) at \(timeStamp)\(fileExtension)")
		print("The file URL is \(filePath).")
		return filePath
	}

	func fetchRecordings() {
		print("Fetching recordings.")

		// empty the array so we don't end up with duplicates
		recordings.removeAll()

		let fileManager = FileManager.default
		let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]

		do {
		let directoryContents = try fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
			for url in directoryContents {
	let recording = Recording(fileURL: url)
				recordings.append(recording)
				recordings.sort(by: { $0.calendarDate.compare($1.calendarDate) == .orderedAscending})
			}
		} catch {
			print("Unable to fetch recordings because unable to get the contents of the documents directory in the app's container.")
		} // end do try catch
	} // func

	func delete(_ recording: Recording) {
		let url = recording.fileURL
		print("Deleting \(url).")
		do {
			try FileManager.default.removeItem(at: url)
			print("File deleted.")
		} catch {
			print("Could not delete \(url). The error was: \(error.localizedDescription)")
		} // do try catch

fetchRecordings()
	}

	func delete(_ urlsToDelete: [URL]) {
			for url in urlsToDelete {
				print("Deleting \(url).")
				do {
				   try FileManager.default.removeItem(at: url)
					print("File deleted.")
				} catch {
					print("Could not delete \(url). The error was: \(error.localizedDescription)")
				} // do try catch
			} // loop

		fetchRecordings()
	} // func

	override init() {
		super.init()
		fetchRecordings()
	}
} // class

//
//  AudioRecorder.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

