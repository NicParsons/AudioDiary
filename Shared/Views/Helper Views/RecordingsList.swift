import SwiftUI

struct RecordingsList: View {
	@EnvironmentObject var model: Model
	var recordings: [Recording]
	@State private var selected: Recording?
	@State private var confirmationDialogIsShown = false

    var body: some View {
		List(recordings, id: \.self, selection: $selected) { recording in
RecordingRow(recording: recording)
			// tried putting the accessibilityAction here but it didn't have the desired effect
			} // List
		.frame(minWidth: 200, maxWidth: 400)
		#if os(macOS)
		.onDeleteCommand(perform: {
			if selected != nil { confirmationDialogIsShown = true }
		})
		#endif
		.confirmationDialog("Delete \(selected?.description ?? "nothing")?",
							isPresented: $confirmationDialogIsShown,
							titleVisibility: .visible,
							presenting: selected) { recording in
			Button(role: .destructive) {
				model.delete(recording)
				selected = nil
		} label: {
			Text("Delete")
			} // button
			Button("Cancel", role: .cancel) {
// do nothing
			}
		} message: { _ in
			Text("This action cannot be undone.")
		} // confirmation dialog
		.overlay(Group {
			if recordings.isEmpty {
				Text("You haven't recorded a diary entry for this day yet. Hit the “Record” button to get started.")
					.font(.largeTitle)
			} // end if
		}) // overlay group
    } // body

	// if we later allow multiple selections
	func delete(at offsets: IndexSet) {
			var files = [URL]()
			for index in offsets {
				files.append(recordings[index].fileURL)
			}
			model.delete(files)
		}
} // view

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
		RecordingsList(recordings: [Recording]())
			.environmentObject(Model())
    }
}

//
//  RecordingsList.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

