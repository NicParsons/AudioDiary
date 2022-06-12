import SwiftUI

struct PlaybackControlsMenu: Commands {
	@StateObject var model = Model()
	// @FocusedValue(\.selection) private var selectedID: UUID??
	@FocusedValue(\.recording) private var selectedRecording: Recording??

    var body: some Commands {
		CommandMenu("Controls") {
			// if let selectedID = selectedID {
			if let unwrappedRecording = selectedRecording, let recording = unwrappedRecording {
				PlayPauseButton(recordingURL: recording.fileURL)
				.environmentObject(model)
			} else {
				PlayPauseButton(recordingURL: nil)
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

