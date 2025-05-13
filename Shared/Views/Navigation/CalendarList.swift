import SwiftUI

struct CalendarList: View {
	@EnvironmentObject var model: Model
	@SceneStorage("calendarListSelection") var selection: UUID?
	@State private var confirmationDialogIsShown = false

    var body: some View {
		NavigationView {
			ScrollViewReader { proxy in
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
				// on macOS, we want the accessibility actions to be available without needing to first interact with the list to select the individual recording row
				// so adding the accessibility VO actions to the list view in addition to the RecordingRow view
				// but if we do this on iOS as well it will result in getting the accessibility actions twice
				#if os(macOS)
		.addDiaryEntryVOActions(model: model, selectedRecording: selectedRecording, confirmationDialogIsShown: $confirmationDialogIsShown)
				#endif
		.enableDeletingWithKeyboard(of: selection, confirmationDialogIsShown: $confirmationDialogIsShown)
		.confirmDeletion(ofSelected: selectedRecordingBinding, from: model, if: $confirmationDialogIsShown)
		.onAppear {
			if selection == nil {
				if let mostRecentDay = model.recordingsByDay.last {
					selection = mostRecentDay.diaryEntries.last?.id
				} // end if let
			} // end if
		} // on appear
		.onChange(of: selection) { newValue in
			proxy.scrollTo(newValue)
		}
		.overlay(Group {
			if model.recordings.isEmpty {
				Text("Diary entries that you record or import in the “Today” view will show up here.")
					.font(.largeTitle)
					.multilineTextAlignment(.center)
			}
		}) // overlay group
			} // ScrollViewReader
			// Magic Tap is only available on iOS
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
	// this is needed for the Focus Scene Value to pass to the menu bar controls, but is useful for other stuff as well
	var selectedRecording: Recording? {
		if let selectedID = selection, let selectedRecording = model[selectedID] {
			return selectedRecording
		} else {
return nil
		}
	}

	// this is needed for the confirmDeletion(of:) modifier
	var selectedRecordingBinding: Binding<Recording?> {
		get {
			if let selectedID = selection {
				return $model[selectedID]
			} else {
				return Binding.constant(nil)
			} // end if
		} set {
			selection = newValue.wrappedValue?.id ?? nil
		} // setter
	}
} // extension

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
			.environmentObject(Model())
    }
}


//  CalendarList.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022
