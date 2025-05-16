import SwiftUI

struct RecordingRow: View {
	let recording: Recording
	@EnvironmentObject var model: Model
	@State private var confirmationDialogIsShown = false
	@State private var duration: Int = 0

    var body: some View {
		HStack {
			HStack {
				if nowPlaying() {
					Image(systemName: "waveform.circle.fill")
				} else {
	Image(systemName: "waveform.circle")
				}
				Text("\(recording.shortDescription.capitalizingFirstLetter()) (\(duration == 0 ? "" : duration.formattedAsDuration()))")
			}
			.accessibilityElement(children: .combine)
			.accessibilityLabel(Text(recording.shortDescription.capitalizingFirstLetter() + " (\(duration.formattedAsDuration()))" + (nowPlaying() ? "(now playing)" : "")))
			#if os(macOS)
			Spacer()
			PlayPauseButton(recordingURL: recording.fileURL)
			DownloadButton(recording: recording)
			DeleteButton(shouldDelete: $confirmationDialogIsShown)
			#else
			recording.statusIndicator
			#endif
		} // HStack
		.padding()
		.frame(maxWidth: .infinity)
		.frame(height: 50)
		.confirmDeletion(ofSelected: recordingBinding, from: model, if: $confirmationDialogIsShown)
		/*
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
			Text("Deleting the recording will remove it from iCloud and from all your devices signed into iCloud. This action cannot be undone.")
		} // confirmation dialog
*/
		// macOS automatically combines the RecordingRow into one accessibility element which VoiceOver can interact with to access the child elements
		// but on iOS the elements are separate by default which makes navigating more verbose and will make it difficult to know which play/delete button relates to which entry
#if os(iOS)
.accessibilityElement(children: .combine)
.addDiaryEntryVOActions(model: model, selectedRecording: recording, confirmationDialogIsShown: $confirmationDialogIsShown)
		// combining the children means that the default action on the element triggers all child buttons
		// unless we override it like this
.accessibilityAction { playPause() }
#endif
		.onAppear {
			Task {
			await duration = recording.duration()
			}
		}
    } // body

	func nowPlaying() -> Bool {
		return model.isPlaying && model.audioPlayer.url == recording.fileURL
	}

	func playPause() {
		nowPlaying() ? model.pause() : model.startPlaying(recording.fileURL)
	}
} // View

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
		RecordingRow(recording: Recording(fileURL: Model().dummyURL()))
			.environmentObject(Model())
    }
}

extension RecordingRow {
	var recordingBinding: Binding<Recording?> {
		$model[recording.id]
	}
}

//  RecordingRow.swift
//  AudioDiary
//  Created by Nicholas Parsons on 17/4/2022.
