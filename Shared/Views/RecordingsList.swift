import SwiftUI

struct RecordingsList: View {
	@EnvironmentObject var audioRecorder: AudioRecorder
	var recordings: [Recording]

    var body: some View {
		List {
			ForEach(recordings) { recording in
RecordingRow(recording: recording)
			}
		} // list
    } // body
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

