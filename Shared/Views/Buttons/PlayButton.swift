import SwiftUI

struct PlayButton: View {
	@EnvironmentObject var model: Model
	let recordingID: UUID?
    var body: some View {
		Button(action: {
			if let id = recordingID, let recording = model[id] {
				model.startPlaying(recording.fileURL)
			} // if let
		}) {
			Label("Play", systemImage: "play.circle")
		} // button
		.foregroundColor(.green)
		.disabled(recordingID == nil)
		.keyboardShortcut(" ", modifiers: [])
    } // body
} // View

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
		PlayButton(recordingID: UUID())
			.environmentObject(Model())
    }
}

//  PlayButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022
