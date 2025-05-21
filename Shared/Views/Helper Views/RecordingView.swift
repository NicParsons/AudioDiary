import SwiftUI

struct RecordingView: View {
	@EnvironmentObject var model: Model
	let recording: Recording
@State private var duration = 0

    var body: some View {
		NavigationStack {
			VStack {
				Text("Eventually, author details will go here, followed by the transcript/notes.")

				Spacer()

NowPlayingView(recording: recording)
			} // VStack
			.padding()
			.frame(maxWidth: .infinity, maxHeight: .infinity)
			.background(Color.blue.opacity(0.1))
			.gesture(
// but VO doesn't recognise it yet
				DragGesture(minimumDistance: 30)
					.onEnded { value in
						if value.translation.height < -50 {
							print("Swiped up.")
							model.startPlaying(recording.fileURL)
						} else if value.translation.height > 50 {
							print("Swiped down.")
							model.pause()
						} // end if
					} // ended
			) // Gesture
		} // Nav Stack
		.navigationTitle(recording.description.capitalizingFirstLetter())
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
ShareButton(recording: recording)
			} // toolbar item
		} // toolbar
		.onAppear {
			// not needed on macOS due to better keyboard navigation
			#if os(iOS)
			model.startPlaying(recording.fileURL)
			#endif
			Task {
				await duration = recording.duration()
			} // Task
		} // on appear
		#if os(iOS)
		.onDisappear {
			if model.isPlaying(recording.fileURL) { model.pause() }
		} // on disappear
		#endif
    } // body
} // view
