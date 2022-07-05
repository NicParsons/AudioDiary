import SwiftUI

struct FileMenu: Commands {
	@ObservedObject var model: Model
	@FocusedValue(\.recording) private var selectedRecording: Recording??
	var body: some Commands {
		CommandGroup(after: .newItem) {
			ImportButton()
				.environmentObject(model)
			#if os(macOS)
			if let recording = selectedRecording {
				ExportButton(recordingURL: recording?.fileURL)
				.environmentObject(model)
				.keyboardShortcut("e", modifiers: [.command])
			} else {
				ExportButton(recordingURL: nil)
			} // if let
			#endif
		} // command group
	} // body
} // Commands struct

//  FileMenu.swift
//  AudioDiary
//  Created by Nicholas Parsons on 21/4/2022.
