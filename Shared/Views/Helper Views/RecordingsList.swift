import SwiftUI

struct RecordingsList: View {
	@EnvironmentObject var model: Model
	var recordings: [Recording]
	let date: Date
	@State private var selected: Recording?
	@State private var confirmationDialogIsShown = false

    var body: some View {
		List(recordings, id: \.self, selection: $selected) { recording in
RecordingRow(recording: recording)
			// tried putting the accessibilityAction here but it didn't have the desired effect
			} // List
		.focusedSceneValue(\.recording, selected)
		.frame(minWidth: 200, maxWidth: 400)
		.addDiaryEntryVOActions(model: model, selectedRecording: selected, confirmationDialogIsShown: $confirmationDialogIsShown)
		.enableDeletingWithKeyboard(of: selected, confirmationDialogIsShown: $confirmationDialogIsShown)
		.confirmDeletion(ofSelected: $selected, from: model, if: $confirmationDialogIsShown)
		.overlay(Group {
			if recordings.isEmpty {
				Text("You haven't recorded a diary entry for \(date.stringWithRelativeFormatting().lowercased()) yet. Hit the “Record” button to get started.")
					.font(.largeTitle)
			} // end if
		}) // overlay group
#if os(iOS)
.accessibilityAction(.magicTap) {
if model.isPlaying {
	model.pause()
} else {
		model.resumePlayback()
} // end if
} // magic tap action
#endif
    } // body

	// if we later allow multiple selections
	func delete(at offsets: IndexSet) {
			var files = [URL]()
			for index in offsets {
				files.append(recordings[index].fileURL)
			}
			model.delete(files)
		}

	/* if we ever want a simpler way to initialise this view, we could use the following code
	init(recordings: [Recording]) {
		self.recordings = recordings
		self.date = nil
	}

	 // but if we use a custom initialiser we have to replace the default initialiser as well
	init(recordings: [Recording], date: Date) {
		self.recordings = recordings
		self.date = date
	}

	 // and we'd also have to make the date constant an optional,
	 // conditionally force unwrap it in the Text view, and
	 // provide an alternative string to use if it is nil
	 // or derive the date from the date of one of the recordings
	 */
} // view

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
		RecordingsList(recordings: [Recording](), date: Date())
			.environmentObject(Model())
    }
}

//
//  RecordingsList.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

