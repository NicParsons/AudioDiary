import SwiftUI

struct DayView: View {
	@EnvironmentObject var model: Model
	let date: Date
	@State private var todaysRecordings: [Recording] = []

    var body: some View {
		NavigationView {
		VStack {
			RecordingsList(recordings: todaysRecordings, date: date)

			Spacer()

			HStack {
			RecordButton()
				Spacer()
				ImportButton()
			} // HStack
		} // VStack
#if os(iOS)
.accessibilityAction(.magicTap) {
if model.isPlaying {
	model.pause()
} else if model.isRecording {
	model.stopRecording()
} else {
	model.startRecording()
} // end if
} // magic tap action
#endif
		} // Navigation View
		.navigationTitle(Text(date.stringWithRelativeFormatting()))
		.onAppear { todaysRecordings = model.recordings(for: date) }
    } // body
} // view

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
		DayView(date: Date())
			.environmentObject(Model())
    }
}

//
//  DayView.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

