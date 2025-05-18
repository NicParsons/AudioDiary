import Foundation

extension Double {
	func formattedAsDuration(_ unitsStyle: DateComponentsFormatter.UnitsStyle = .positional) -> String {
		let formatter = DateComponentsFormatter()
		formatter.allowedUnits = [.minute, .second]
		formatter.zeroFormattingBehavior = .pad
		formatter.unitsStyle = unitsStyle
		return formatter.string(from: TimeInterval(self))!
	}
}
