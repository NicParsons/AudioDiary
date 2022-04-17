import Foundation

extension Date {
	func isOnTheSameDay(as comparisonDate: Date) -> Bool {
		let diff = Calendar.current.dateComponents([.day], from: self, to: comparisonDate)
		if diff.day == 0 {
			return true
		} else {
			return false
		} // end if
	} // func
} // extension

//  DateExtensions.swift
//  AudioDiary
//  Created by Nicholas Parsons on 17/4/2022.
