import SwiftUI

struct StopPlayingButton: View {
	@EnvironmentObject var model: Model
    var body: some View {
		Button(action: {
			model.stopPlaying()
		}) {
			Label("Stop", systemImage: "stop.circle")
		} // button
		.foregroundColor(.red)
		.disabled(!model.isPlaying)
		.keyboardShortcut(".", modifiers: [.command])
    } // body
} // View

struct StopPlayingButton_Previews: PreviewProvider {
    static var previews: some View {
        StopPlayingButton()
			.environmentObject(Model())
    }
}

//  StopPlayingButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
