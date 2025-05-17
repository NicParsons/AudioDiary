import Foundation

struct CalendarDay: Hashable, Identifiable {
	let id: Date
	var date: Date { id }
	var diaryEntries = [Recording]()

	init(for date: Date) {
		id = Calendar.current.startOfDay(for: date)
	}
}
