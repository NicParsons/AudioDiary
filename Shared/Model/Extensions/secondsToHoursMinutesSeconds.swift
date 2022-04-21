import Foundation

func secondsToHoursMinutesSeconds(_ seconds: Int) -> (Int, Int, Int) {
	return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
}

//
//  secondsToHoursMinutesSeconds.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 21/4/2022.
//

