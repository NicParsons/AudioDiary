import SwiftUI

struct PlayPauseButton: View {
	@EnvironmentObject var model: Model
	let recordingID: UUID?
    var body: some View {
		Button(action: {
			if let id = recordingID, let recording = model[id] {
				if model.isPlaying && model.currentlyPlayingURL == recording.fileURL {
					model.pause()
				} else if model.currentlyPlayingURL == recording.fileURL {
					model.resumePlayback()
				} else {
				model.startPlaying(recording.fileURL)
				} // end if
			} // if let
		}) {
			if let id = recordingID, let recording = model[id] {
				if model.isPlaying && model.currentlyPlayingURL == recording.fileURL {
Label("Pause", systemImage: "pause.circle")
						.background(Color.red)
						.foregroundColor(.white)
						.cornerRadius(8)
				} else {
			Label("Play", systemImage: "play.circle")
						.background(Color.green)
						.foregroundColor(.white)
						.cornerRadius(8)
				} // end if
			} else {
		Label("Play", systemImage: "play.circle")
					.background(Color.green)
					.foregroundColor(.white)
					.cornerRadius(8)
			} // end if let
		} // button
		.disabled(recordingID == nil)
		// .keyboardShortcut(" ", modifiers: [])
    } // body
} // view

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayPauseButton(recordingID: UUID())
    }
}

//  PlayPauseButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 21/4/2022.
