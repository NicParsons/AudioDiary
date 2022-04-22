import Foundation
import AppKit
import UniformTypeIdentifiers

func showOpenPanel() -> [URL]? {
	let openPanel = NSOpenPanel()
	openPanel.allowedContentTypes = [UTType.audio]
	openPanel.allowsMultipleSelection = true
	openPanel.canChooseDirectories = false
	openPanel.canChooseFiles = true
	let response = openPanel.runModal()
	return response == .OK ? openPanel.urls : nil
}

//  showOpenPanel.swift
//  AudioDiary (macOS)
//  Created by Nicholas Parsons on 22/4/2022.
