import SwiftUI

struct RecordingRow: View {
	let recording: Recording
	@EnvironmentObject var model: Model
	@State private var confirmationDialogIsShown = false

    var body: some View {
		HStack {
			Text(recording.shortDescription.capitalizingFirstLetter())
			Spacer()
			if !model.isPlaying {
				PlayButton(recordingID: recording.id)
			} else {
				StopPlayingButton()
			} // end if isPlaying

			Button(action: {
confirmationDialogIsShown = true
			}) {
				Label("Delete", systemImage: "trash.circle")
			}
		} // HStack
		.padding()
		.frame(maxWidth: .infinity)
		.frame(height: 50)
		.confirmationDialog("Delete \(recording.description)?",
							isPresented: $confirmationDialogIsShown,
							titleVisibility: .visible,
							presenting: recording) { _ in
			Button(role: .destructive) {
				model.delete(recording)
		} label: {
			Text("Delete")
			} // button
			Button("Cancel", role: .cancel) {
// do nothing
			}
		} message: { _ in
			Text("This action cannot be undone.")
		} // confirmation dialog

		// accessibility actions
		.accessibilityAction(named: Text(model.isPlaying ? "Pause" : "Play")) {
			if model.isPlaying {
				model.pause()
			} else {
				model.startPlaying(recording.fileURL)
			} // end if
		} // end action
		.accessibilityAction(named: Text("Delete")) {
			confirmationDialogIsShown = true
		}
    } // body
} // View

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
		RecordingRow(recording: Recording(fileURL: Model().dummyURL()))
			.environmentObject(Model())
    }
}

//
//  RecordingRow.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 17/4/2022.
//

