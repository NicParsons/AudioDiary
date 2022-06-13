import SwiftUI

struct FileMenu: Commands {
	@ObservedObject var model: Model
	var body: some Commands {
		CommandGroup(after: .newItem) {
			ImportButton()
				.environmentObject(model)
		}
	} // body
} // Commands struct

//  FileMenu.swift
//  AudioDiary
//  Created by Nicholas Parsons on 21/4/2022.
