import SwiftUI

struct RecordingsList: View {
	@EnvironmentObject var audioRecorder: AudioRecorder
	var recordings: [Recording]
	@State private var selected: Recording?

    var body: some View {
		List(recordings, id: \.self, selection: $selected) { recording in
RecordingRow(recording: recording)
			// tried putting the accessibilityAction here but it didn't have the desired effect
			} // List
		.onDeleteCommand(perform: { delete(selected) })
    } // body

	func delete(_ selected: Recording?) {
					if let selected = selected {
						audioRecorder.delete(selected.fileURL)
					} // end if let
	} // func

	func delete(at offsets: IndexSet) {
			var files = [URL]()
			for index in offsets {
				files.append(recordings[index].fileURL)
			}
			audioRecorder.delete(files)
		}
} // view

struct RecordingsList_Previews: PreviewProvider {
    static var previews: some View {
		RecordingsList(recordings: [Recording]())
			.environmentObject(AudioRecorder())
    }
}

//
//  RecordingsList.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

