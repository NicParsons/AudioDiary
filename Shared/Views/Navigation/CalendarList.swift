import SwiftUI

struct CalendarList: View {
	@EnvironmentObject var model: Model
	@State private var selection: UUID?
	@State private var confirmationDialogIsShown = false

    var body: some View {
		NavigationView {
		List(selection: $selection) {
			ForEach(model.recordingsByDay) { day in
				Section(header: Text(day.date.formatted(date: .complete, time: .omitted))) {
					ForEach(day.diaryEntries) { recording in
RecordingRow(recording: recording)
					} // ForEach
			} // Section
			} // ForEach
		} // List
		.focusedSceneValue(\.recording, selectedRecording)
#if os(macOS)
.onDeleteCommand(perform: {
	print("Delete key pressed.")
	if selection != nil { confirmationDialogIsShown = true }
} )
#endif
		// force unwrapping should be safe here as it's conditional on selection
		.confirmationDialog("Delete \(selection == nil ? "nothing" : model[selection!] == nil ? "nothing" : model[selection!]!.description)?",
							isPresented: $confirmationDialogIsShown,
							titleVisibility: .visible,
							presenting: selection) { recordingID in
			Button(role: .destructive) {
				if let recording = model[recordingID] {
				model.delete(recording)
					self.selection = nil
				} // end if
		} label: {
			Text("Delete")
			} // button
			Button("Cancel", role: .cancel) {
// do nothing
			}
		} message: { _ in
			Text("Deleting the recording will remove it from icloud and from all your devices signed into icloud. This action cannot be undone.")
		} // confirmation dialog
		.overlay(Group {
			if model.recordings.isEmpty {
				Text("Diary entries that you record or import in the “Today” view will show up here.")
					.font(.largeTitle)
					.multilineTextAlignment(.center)
			}
		}) // overlay group
		} // NavigationView
		.navigationTitle(Text("Your Audio Journal"))
		.toolbar {
			#if os(iOS)
			ToolbarItem(placement: .navigationBarTrailing) {
			EditButton()
		} // ToolbarItem
		#endif
		} // Toolbar
    } // body
} // View

extension CalendarList {
	var selectedRecording: Recording? {
		if let selectedID = selection, let selectedRecording = model[selectedID] {
			return selectedRecording
		} else {
return nil
		}
	}
}

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
			.environmentObject(Model())
    }
}


//  CalendarList.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022
