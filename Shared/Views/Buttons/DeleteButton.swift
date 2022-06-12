import SwiftUI

// sets the bound boolean to true to signal the parent view to display a confirmation dialog
struct DeleteButton: View {
	@Binding var shouldDelete: Bool

    var body: some View {
		Button(action: {
			shouldDelete = true
		}) {
			Label("Delete", systemImage: "trash.circle")
		}
    }
}

struct DeleteButton_Previews: PreviewProvider {
    static var previews: some View {
		DeleteButton(shouldDelete: .constant(false))
    }
}

//  DeleteButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 12/6/2022.
