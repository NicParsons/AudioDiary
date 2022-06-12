import SwiftUI

extension FocusedValues {
	var recording: Recording?? {
		get { self[FocusedRecordingKey.self] }
		set { self[FocusedRecordingKey.self] = newValue }
	}

	var selection: Recording.ID?? {
		get { self[FocusedRecordingSelectionKey.self] }
		set { self[FocusedRecordingSelectionKey.self] = newValue }
	}

	private struct FocusedRecordingKey: FocusedValueKey {
		typealias Value = Recording?
	}

	private struct FocusedRecordingSelectionKey: FocusedValueKey {
		typealias Value = Recording.ID?
	}
}

//  FocusValues.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
