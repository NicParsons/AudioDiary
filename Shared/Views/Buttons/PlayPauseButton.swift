import SwiftUI

struct PlayPauseButton: View {
	@EnvironmentObject var model: Model
	let recordingID: UUID?
    var body: some View {
		Button(action: {
			if let id = recordingID, let recording = model[id] {
				if model.isPlaying && model.currentlyPlayingURL == recording.fileURL {
					model.pause()
				} else {
				model.startPlaying(recording.fileURL)
				} // end if
			} // if let
		}) {
			if let id = recordingID, let recording = model[id] {
				if model.isPlaying && model.currentlyPlayingURL == recording.fileURL {
Label("Pause", systemImage: "pause.circle")
				} else {
			Label("Play", systemImage: "play.circle")
				} // end if
			} else {
		Label("Play", systemImage: "play.circle")
			} // end if let
		} // button
		.foregroundColor(model.isPlaying ? .red : .green)
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
