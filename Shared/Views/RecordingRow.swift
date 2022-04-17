import SwiftUI

struct RecordingRow: View {
	let recording: Recording
	@EnvironmentObject var audioRecorder: AudioRecorder
	@ObservedObject var audioPlayer = AudioPlayer()
	@State private var confirmationDialogIsShown = false

    var body: some View {
		HStack {
			Text(recording.timeStamp)
			Spacer()
			if audioPlayer.isPlaying == false {
				Button(action: {
					audioPlayer.startPlaying(recording.fileURL)
				}) {
					Label("Play", systemImage: "play.circle")
				} // button
				.foregroundColor(.green)
			} else {
				Button(action: {
					audioPlayer.stopPlaying()
				}) {
					Label("Stop", systemImage: "stop.circle")
				} // button
				.foregroundColor(.red)
			} // end if isPlaying

			Button(action: {
confirmationDialogIsShown = true
			}) {
				Label("Delete", systemImage: "trash.circle")
			}
		} // HStack
		.padding()
		.confirmationDialog("Delete \(recording.description)?",
							isPresented: $confirmationDialogIsShown,
							titleVisibility: .visible,
							presenting: recording) { _ in
			Button(role: .destructive) {
				audioRecorder.delete(recording)
		} label: {
			Text("Delete")
			} // button
			Button("Cancel", role: .cancel) {
// do nothing
			}
		} message: { _ in
			Text("This action cannot be undone.")
		} // confirmation dialog
    } // body
} // View

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
		RecordingRow(recording: Recording(fileURL: AudioRecorder().dummyURL()))
    }
}

//
//  RecordingRow.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 17/4/2022.
//

