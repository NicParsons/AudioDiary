//
//  FileMenu.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 21/4/2022.
//

import SwiftUI


struct FileMenu: Commands {
	@StateObject var model = Model()
	var body: some Commands {
		CommandGroup(after: .newItem) {
			RecordButton()
				.keyboardShortcut("r", modifiers: [.command])
				.environmentObject(model)
		}
	} // body
} // Commands struct