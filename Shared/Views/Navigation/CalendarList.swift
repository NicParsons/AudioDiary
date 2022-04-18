import SwiftUI

struct CalendarList: View {
	@EnvironmentObject var audioRecorder: AudioRecorder
	@State private var selectedEntryID: UUID?

    var body: some View {
		List(selection: $selectedEntryID) {
			ForEach(audioRecorder.recordingsByDay) { day in
				Section(header: Text(day.date.formatted(date: .complete, time: .omitted))) {
					ForEach(day.diaryEntries) { recording in
RecordingRow(recording: recording)
					} // ForEach
			} // Section
			} // ForEach
		} // List
		.navigationTitle(Text("Your Audio Journal"))
    } // body
} // View

struct CalendarList_Previews: PreviewProvider {
    static var previews: some View {
        CalendarList()
    }
}


//  CalendarList.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022
