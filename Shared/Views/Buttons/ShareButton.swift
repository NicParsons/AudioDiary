import SwiftUI

struct ShareButton: View {
	@EnvironmentObject var model: Model
	let recording: Recording
    var body: some View {
ShareLink(
	item: recording,
	subject: Text(recording.description),
	message: Text(recording.description),
	preview: SharePreview(
		recording.description,
		image: Image(systemName: "waveform.circle")
	) // SharePreivew
) // ShareLink
    }
}
