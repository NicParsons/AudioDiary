import SwiftUI

struct RecordingRow: View {
	let recording: Recording

    var body: some View {
		HStack {
			Text(recording.timeStamp)
			Spacer()
		} // HStack
    } // body
} // View

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
		RecordingRow(recording: Recording(fileURL: AudioRecorder().dummyURL()))
    }
}

//
//  RecordingRow.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 17/4/2022.
//

