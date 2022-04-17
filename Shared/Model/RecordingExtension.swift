import Foundation

extension AudioRecorder {
	func dummyURL() -> URL {
	let fileManager = 		FileManager.default
	let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
	   let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
return directoryContents[0]
	}
}

//
//  RecordingExtension.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 17/4/2022.
//

