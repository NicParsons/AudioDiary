import SwiftUI

struct TodayView: View {
    var body: some View {
        DayView(date: Date())
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
			.environmentObject(Model())
    }
}

//  TodayView.swift
//  AudioDiary
//  Created by Nicholas Parsons on 17/4/2022.
