import Foundation

extension UUID: @retroactive RawRepresentable {
	public var rawValue: String {
		self.uuidString
	}

	public typealias RawValue = String

	public init?(rawValue: String) {
		self.init(uuidString: rawValue)
	}
}

//  UUIDExtension.swift
//  AudioDiary
//  Created by Nicholas Parsons on 22/6/2022.
