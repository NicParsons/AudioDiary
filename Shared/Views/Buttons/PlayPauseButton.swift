import SwiftUI

struct PlayPauseButton: View {
	@EnvironmentObject var model: Model
	let recordingURL: URL?

    var body: some View {
		Button(action: {
			if let recordingURL = recordingURL {
				if model.isPlaying && model.currentlyPlayingURL == recordingURL {
					model.pause()
				} else if model.currentlyPlayingURL == recordingURL {
					model.resumePlayback()
				} else {
				model.startPlaying(recordingURL)
				} // end if
			} // if let
		}) {
			if let recordingURL = recordingURL {
				if model.isPlaying && model.currentlyPlayingURL == recordingURL {
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
		.disabled(recordingURL == nil)
		// .keyboardShortcut(" ", modifiers: [])
    } // body
} // view

struct PlayPauseButton_Previews: PreviewProvider {
    static var previews: some View {
		PlayPauseButton(recordingURL: Model().dummyURL())
    }
}

//  PlayPauseButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 21/4/2022.
