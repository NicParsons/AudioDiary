import SwiftUI

struct PlaybackControlsMenu: Commands {
	@StateObject var model = Model()
	@FocusedBinding(\.selection) private var selectedID: UUID?

    var body: some Commands {
		CommandMenu("Controls") {
			PlayPauseButton(recordingID: selectedID)
				.environmentObject(model)
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

