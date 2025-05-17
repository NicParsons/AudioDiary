import SwiftUI

struct RecordingView: View {
	@EnvironmentObject var model: Model
	let recording: Recording
@State private var duration = 0

    var body: some View {
		NavigationStack {
			VStack {
				Text("Duration: \(duration.formattedAsDuration())")

				Spacer()

AudioControlsView(recording: recording)
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
		.navigationTitle(recording.description)
		.onAppear {
			model.startPlaying(recording.fileURL)
			Task {
				await duration = recording.duration()
			} // Task
		} // on appear
    } // body
} // view
