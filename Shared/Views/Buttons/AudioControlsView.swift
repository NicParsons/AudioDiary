import SwiftUI

struct AudioControlsView: View {
	let recording: Recording
    var body: some View {
		HStack {
			PlayPauseButton(recordingURL: recording.fileURL)
			Spacer()
			RecordButton()
		}
    }
}
