import SwiftUI

struct NowPlayingView: View {
	@EnvironmentObject var model: Model
	let recording: Recording
	@State private var duration: TimeInterval = 0
	@State private var currentTime: TimeInterval = 0
	@State private var isSeeking = false
	@State private var timer: Timer?

	var body: some View {
		VStack(spacing: 16) {
			Text(recording.description.capitalizingFirstLetter())
				.font(.headline)
				.accessibilityAddTraits(.isHeader)

			// Scrubber above controls
			VStack {
				Slider(
					value: Binding(
						get: { currentTime },
						set: { newValue in
							currentTime = newValue
							isSeeking = true
						}
					), // Binding
					in: 0...duration
				) {
					Text("Playback position")
				} minimumValueLabel: {
					Text(0.formattedAsDuration())
				} maximumValueLabel: {
					Text(duration.formattedAsDuration())
				} onEditingChanged: { editing in
					if !editing {
						model.setPlaybackPosition(to: currentTime)
						isSeeking = false
					} // end if
				} // on editing Slider
				.accessibilityValue(Text("\(currentTime.formattedAsDuration()) of \(duration.formattedAsDuration())"))

				HStack {
					Text(currentTime.formattedAsDuration())
					Spacer()
					Text("/")
					Spacer()
					Text(duration.formattedAsDuration())
				} // H Stack
				.font(.caption)
				.accessibilityElement(children: .combine)
			} // V Stack for scrubber

			// Playback controls
			HStack {
				Button(action: {
					model.seekBackward(15)
				}) {
					Label("Go backward 15 seconds", systemImage: "gobackward.15")
				} // button
				.accessibilityLabel("Go backward 15 seconds")

				PlayPauseButton(recordingURL: recording.fileURL)

				Button(action: {
					model.seekForward(15)
				}) {
					Label("Go forward 15 seconds", systemImage: "goforward.15")
				} // button
				.accessibilityLabel("Go forward 15 seconds")
			} // H Stack for playback controls
		} // V Stack
		.padding()
		.frame(maxWidth: 500)
		.frame(minHeight: 150, maxHeight: 250)
		.onAppear {
			Task {
				self.duration = Double(await recording.duration())
				startTimer()
			} // task
		} // on appear
		.onDisappear {
			stopTimer()
		} // on disappear
	} // body

	func startTimer() {
		timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
			guard !isSeeking, let player = model.audioPlayer else { return }
			currentTime = player.currentTime
		} // timer
	} // func

	func stopTimer() {
		timer?.invalidate()
		timer = nil
	} // func

} // View
