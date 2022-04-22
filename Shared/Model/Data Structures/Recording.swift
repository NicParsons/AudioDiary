import Foundation
import AVFoundation

struct Recording: Codable, Identifiable, Hashable {
	var id = UUID()
	var fileURL: URL

	var creationDate: Date {
			if let attributes = try? FileManager.default.attributesOfItem(atPath: fileURL.path) as [FileAttributeKey: Any],
				let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
				return creationDate
			} else {
				return Date()
			} // end if
		} // end creationDate

	var calendarDate: Date {
		// for now
return creationDate
	}

	var timeStamp: String {
		calendarDate.formatted(date: .omitted, time: .shortened)
	}

	var fileName: String {
		fileURL.lastPathComponent
	}

	var description: String {
		return "diary entry for \(calendarDate.formatted(date: .abbreviated, time: .omitted)) at \(calendarDate.formatted(date: .omitted, time: .shortened))"
	}

	var shortDescription: String {
		return "entry at \(timeStamp)"
	}

	func duration() async -> Int {
		var seconds: Int
		let audioAsset = AVAsset(url: fileURL)
		do {
			let CMTimeDuration = try await audioAsset.load(.duration)
			seconds = Int(CMTimeDuration.seconds)
		} catch {
			seconds = 0
		}
		return seconds
	} // func
} // Recording struct

//  Recording.swift
//  AudioDiary
//  Created by Nicholas Parsons on 16/4/2022.
