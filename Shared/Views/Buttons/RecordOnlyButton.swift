import SwiftUI
import AVFoundation

struct RecordOnlyButton: View {
	@EnvironmentObject var model: Model
	@State private var alertIsPresent = false

	var body: some View {
			Button(
				action: {
					switch AVCaptureDevice.authorizationStatus(for: .audio) {
					case .authorized:
						self.model.startRecording()
					case .notDetermined:
						print("About to prompt for access to the microphone.")
						AVCaptureDevice.requestAccess(for: .audio) { granted in
							if granted {
								self.model.startRecording()
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
			} // Button
				.accessibilityAddTraits(.startsMediaSession)
				.foregroundColor(.green)
				.disabled(model.isRecording)
	.alert("Please grant the app access to your microphone",
		   isPresented: $alertIsPresent) {
		Button("OK", action: { print("The user dismissed the custom alert asking them to grant access to the microphone.") })
	} message: {
		Text("You need to allow AudioDiary to access your microphone before it can record.")
		// conditionally show instructions depending on what platform/os
	} // alert
	} // body
} // View

struct RecordOnlyButton_Previews: PreviewProvider {
    static var previews: some View {
        RecordOnlyButton()
    }
}

//  RecordOnlyButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 22/4/2022.
