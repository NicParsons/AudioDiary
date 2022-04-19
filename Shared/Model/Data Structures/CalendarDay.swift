//
//  CalendarDay.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 18/4/2022.
//

import Foundation

struct CalendarDay: Hashable, Identifiable {
	let id: Date
	var date: Date { id }
	var diaryEntries = [Recording]()

	init(for date: Date) {
		id = Calendar.current.startOfDay(for: date)
	}
}
