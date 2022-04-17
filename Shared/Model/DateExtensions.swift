import Foundation

extension Date {
	func isOnTheSameDay(as comparisonDate: Date) -> Bool {
		let beginningOfDay = Calendar.current.startOfDay(for: comparisonDate)
		let endOfDay = beginningOfDay.addingTimeInterval(60 * 60 * 24)
		return self >= beginningOfDay && self < endOfDay
	} // func

	func stringWithRelativeFormatting() -> String {
		let formatter = DateFormatter()
		formatter.dateStyle = .long
		formatter.timeStyle = .none
		formatter.doesRelativeDateFormatting = true
		return formatter.string(from: self)
	}
} // extension

//  DateExtensions.swift
//  AudioDiary
//  Created by Nicholas Parsons on 17/4/2022.
