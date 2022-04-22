import SwiftUI

struct DayView: View {
	@EnvironmentObject var model: Model
	let date: Date

    var body: some View {
		NavigationView {
		VStack {
			RecordingsList(recordings: model.recordings(for: date), date: date)

			Spacer()

			HStack {
			RecordButton()
				Spacer()
				ImportButton()
			} // HStack
		} // VStack
		} // Navigation View
		.navigationTitle(Text(date.stringWithRelativeFormatting()))
    } // body
} // view

struct DayView_Previews: PreviewProvider {
    static var previews: some View {
		DayView(date: Date())
			.environmentObject(Model())
    }
}

//
//  DayView.swift
//  AudioDiary
//
//  Created by Nicholas Parsons on 16/4/2022.
//

