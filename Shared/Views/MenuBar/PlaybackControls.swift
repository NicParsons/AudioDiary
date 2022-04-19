import SwiftUI

struct PlaybackControlsMenu: Commands {
	@StateObject var model = Model()
	@FocusedBinding(\.selection) private var selectedID: UUID?

    var body: some Commands {
		CommandMenu("Playback Controls") {
			PlayButton(recordingID: selectedID).environmentObject(model)
			StopPlayingButton().environmentObject(model)
		} // CommandMenu
    } // body
} // Commandds

//  PlaybackControls.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
//

