import SwiftUI

extension View {
	@ViewBuilder func addDiaryEntryVOActions(model: Model, selectedRecording: Recording?, confirmationDialogIsShown: Binding<Bool>) -> some View {
#if os(macOS)
			if let recording = selectedRecording {
			let isPlaying = model.isPlaying && model.currentlyPlayingURL == recording.fileURL
		self
.accessibilityAction(named: Text(isPlaying ? "Pause" : "Play")) {
if isPlaying {
model.pause()
} else {
model.startPlaying(recording.fileURL)
} // end if
} // end action
.accessibilityAction(named: Text("Delete")) {
	confirmationDialogIsShown.wrappedValue = true
}
			} else {
				self
			}
		#else
		self
#endif
	} // func
} // extension

//  addVOActions.swift
//  AudioDiary
//  Created by Nicholas Parsons on 25/6/2022.
