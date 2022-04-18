import Foundation

extension String {
	func capitalizingFirstLetter() -> String {
		return prefix(1).capitalized + dropFirst()
	}

	mutating func capitalizeFirstLetter() {
		self = self.capitalizingFirstLetter()
	}
}

//  StringExtension.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 18/4/2022.
//

