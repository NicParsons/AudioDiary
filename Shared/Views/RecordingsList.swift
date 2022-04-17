import SwiftUI

struct RecordingsList: View {
	@EnvironmentObject var audioRecorder: AudioRecorder
	// @ObservedObject var audioPlayer = AudioPlayer()
	var recordings: [Recording]
	@State private var selected: Recording?

    var body: some View {
		List(recordings, id: \.self, selection: $selected) { recording in
RecordingRow(recording: recording)
			// tried putting the accessibilityAction here but it didn't have the desired effect
			} // List
		.frame(minWidth: 200, maxWidth: 400)
		.onDeleteCommand(perform: { delete(selected) })
		.overlay(Group {
			if recordings.isEmpty {
				Text("You haven't recorded a diary entry for this day yet. Hit the “Record” button to get started.")
					.font(.largeTitle)
			}
		})
    } // body

	func delete(_ selected: Recording?) {
					if let file = selected {
						audioRecorder.delete(file)
						// if audioPlayer.isPlaying && audioPlayer.audioPlayer.url == file.fileURL { audioPlayer.stopPlaying() }
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

