import SwiftUI

struct RecordingRow: View {
	let recording: Recording
	@ObservedObject var audioPlayer = AudioPlayer()

    var body: some View {
		HStack {
			Text(recording.timeStamp)
			Spacer()
			if audioPlayer.isPlaying == false {
				Button(action: {
					audioPlayer.startPlaying(recording.fileURL)
				}) {
					Label("Play", systemImage: "play.circle")
				} // button
				.foregroundColor(.green)
			} else {
				Button(action: {
					audioPlayer.stopPlaying()
				}) {
					Label("Stop", systemImage: "stop.circle")
				} // button
				.foregroundColor(.red)
			} // end if isPlaying
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

