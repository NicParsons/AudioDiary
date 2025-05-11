import SwiftUI

@main
struct AudioDiaryApp: App {
	@StateObject var model = Model()
    // let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
HomeScreen()
				.environmentObject(model)
				// .environment(\.managedObjectContext, persistenceController.container.viewContext)
#if os(iOS)
.accessibilityAction(.magicTap) {
if model.isPlaying {
	model.pause()
} else if model.isRecording {
	model.stopRecording()
} else {
	/* we can do this once we add property to model to detect whether playback is paused
	model.resumePlayback()
	 */
	model.startRecording()
} // end if
} // magic tap action
#endif
        }
		.commands {
			FileMenu(model: model)
			PlaybackControlsMenu(model: model)
		}
    } // body
} // App

//  AudioDiaryApp.swift
//  Shared
//
//  Created by Nicholas Parsons on 16/4/2022.
//

