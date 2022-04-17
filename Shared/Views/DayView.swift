import SwiftUI
import AVFoundation

struct DayView: View {
	@EnvironmentObject var audioRecorder: AudioRecorder
	@State private var alertIsPresent = false
	let date: Date

    var body: some View {
		NavigationView {
		VStack {
			RecordingsList(recordings: audioRecorder.recordings(for: date))

			Spacer()

			if !audioRecorder.isRecording {
				// display the record button
				Button(
					action: {
						switch AVCaptureDevice.authorizationStatus(for: .audio) {
						case .authorized:
							self.audioRecorder.startRecording()
						case .notDetermined:
							print("About to prompt for access to the microphone.")
							AVCaptureDevice.requestAccess(for: .audio) { granted in
								if granted {
									self.audioRecorder.startRecording()
								} else {
									print("The user denied access to the microphone.")
								} // end if access granted
							} // completion handler
						case .denied:
							print("No microphone access.")
alertIsPresent = true
						default:
							print("No microphone access.")
							alertIsPresent = true
						} // switch
					}) {
Label("Record", systemImage: "record.circle")
				}
				.foregroundColor(.green)
			} else {
				// display the stop button
				Button(
					action: { self.audioRecorder.stopRecording() }) {
					Label("Stop", systemImage: "stop.circle")
				}
				.foregroundColor(.red)
			} // end if
		} // v stack
		.alert("Please grant the app access to your microphone",
			   isPresented: $alertIsPresent) {
			Button("OK", action: { print("The user dismissed the custom alert asking them to grant access to the microphone.") })
		} message: {
			Text("You need to allow AudioDiary to access your microphone before it can record.")
			// conditionally show instructions depending on what platform/os
		} // alert
		} // Navigation View
		.navigationTitle(Text(date.formatted(date: .long, time: .omitted)))
    } // body
} // view

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
		DayView(date: Date())
			.environmentObject(AudioRecorder())
    }
}

//
//  DayView.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

