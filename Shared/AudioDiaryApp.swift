import SwiftUI

@main
struct AudioDiaryApp: App {
	@StateObject var model = Model()

    var body: some Scene {
        WindowGroup {
HomeScreen()
				.environmentObject(model)
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
