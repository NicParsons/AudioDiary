import SwiftUI

extension FocusedValues {
	var recording: Binding<Recording>? {
		get { self[FocusedRecordingKey.self] }
		set { self[FocusedRecordingKey.self] = newValue }
	}

	var selection: Binding<Recording.ID>? {
		get { self[FocusedRecordingSelectionKey.self] }
		set { self[FocusedRecordingSelectionKey.self] = newValue }
	}

	private struct FocusedRecordingKey: FocusedValueKey {
		typealias Value = Binding<Recording>
	}

	private struct FocusedRecordingSelectionKey: FocusedValueKey {
		typealias Value = Binding<Recording.ID>
	}
}

//  FocusValues.swift
//  AudioDiary
//  Created by Nicholas Parsons on 18/4/2022.
