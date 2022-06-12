import SwiftUI

struct PlaybackControlsMenu: Commands {
	@ObservedObject var model: Model
	@FocusedValue(\.recording) private var selectedRecording: Recording??

    var body: some Commands {
		CommandMenu("Controls") {
			if let unwrappedRecording = selectedRecording, let recording = unwrappedRecording {
				PlayPauseButton(recordingURL: recording.fileURL)
				.environmentObject(model)
				.keyboardShortcut(.return, modifiers: [])
			} else {
				PlayPauseButton(recordingURL: nil)
					.keyboardShortcut(.return, modifiers: [])
			}
			RecordOnlyButton()
				.environmentObject(model)
				.keyboardShortcut("r", modifiers: [.command])
			StopRecordingButton()
				.environmentObject(model)
				.keyboardShortcut(".", modifiers: [.command])
		} // CommandMenu
    } // body
} // Commandds

//  PlaybackControls.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
//

