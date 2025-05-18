import Foundation

func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
	return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}
