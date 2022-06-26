import SwiftUI

struct DeleteConfirmationDialog: ViewModifier {
	@ObservedObject var model: Model
	@Binding var selectedRecording: Recording?
	@Binding var confirmationDialogIsShown: Bool

	func body(content: Content) -> some View {
content
			.confirmationDialog("Delete \(selectedRecording?.description ?? "nothing")?",
								isPresented: $confirmationDialogIsShown,
								titleVisibility: .visible,
								presenting: selectedRecording) { recording in
				Button(role: .destructive) {
					model.delete(recording)
					selectedRecording = nil
			} label: {
				Text("Delete")
				} // button
				Button("Cancel", role: .cancel) {
	// do nothing
				}
			} message: { _ in
				Text("Deleting the diary entry recording will remove it from iCloud and from all your devices signed into iCloud. This action cannot be undone.")
			} // confirmation dialog
	}
}

extension View {
	func confirmDeletion(ofSelected recording: Binding<Optional<Recording>>, from model: Model, if confirmationDialogIsShown: Binding<Bool>) -> some View {
		modifier(DeleteConfirmationDialog(model: model, selectedRecording: recording, confirmationDialogIsShown: confirmationDialogIsShown))
	}
}

//  deleteRecordingConfirmationDialog.swift
//  AudioDiary
//  Created by Nicholas Parsons on 26/6/2022.

/*
	// force unwrapping should be safe here as it's conditional on selection
	.confirmationDialog("Delete \(selection == nil ? "nothing" : model[selection!] == nil ? "nothing" : model[selection!]!.description)?",
						isPresented: $confirmationDialogIsShown,
						titleVisibility: .visible,
						presenting: selection) { recordingID in
		Button(role: .destructive) {
			if let recording = model[recordingID] {
			model.delete(recording)
				self.selection = nil
			} // end if
	} label: {
		Text("Delete")
		} // button
		Button("Cancel", role: .cancel) {
// do nothing
		}
	} message: { _ in
		Text("Deleting the recording will remove it from icloud and from all your devices signed into icloud. This action cannot be undone.")
	} // confirmation dialog

// force unwrapping should be safe here as it's conditional on selection
.confirmationDialog("Delete \(selection == nil ? "nothing" : model[selection!] == nil ? "nothing" : model[selection!]!.description)?",
					isPresented: $confirmationDialogIsShown,
					titleVisibility: .visible,
					presenting: selection) { recordingID in
	Button(role: .destructive) {
		if let recording = model[recordingID] {
		model.delete(recording)
			self.selection = nil
		} // end if
} label: {
	Text("Delete")
	} // button
	Button("Cancel", role: .cancel) {
// do nothing
	}
} message: { _ in
	Text("Deleting the recording will remove it from icloud and from all your devices signed into icloud. This action cannot be undone.")
} // confirmation dialog
*/
