import SwiftUI

struct CalendarList: View {
	@EnvironmentObject var model: Model
	@State private var selection: UUID?
	@State private var confirmationDialogIsShown = false

    var body: some View {
		List(selection: $selection) {
			ForEach(model.recordingsByDay) { day in
				Section(header: Text(day.date.formatted(date: .complete, time: .omitted))) {
					ForEach(day.diaryEntries) { recording in
RecordingRow(recording: recording)
					} // ForEach
			} // Section
			} // ForEach
		} // List
		.navigationTitle(Text("Your Audio Journal"))
		#if os(macOS)
		.onDeleteCommand(perform: {
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
			Text("This action cannot be undone.")
		} // confirmation dialog
    } // body
} // View

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
			.environmentObject(Model())
    }
}


//  CalendarList.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022
