import Foundation

extension Int {
	func formattedAsDuration(_ unitsStyle: DateComponentsFormatter.UnitsStyle = .positional) -> String {
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.hour, .minute, .second]
		formatter.unitsStyle = unitsStyle
		return formatter.string(from: TimeInterval(self))!
	}
}

//  IntExtension.swift
//  AudioDiary
//  Created by Nicholas Parsons on 21/4/2022.
