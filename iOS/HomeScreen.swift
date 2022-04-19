import SwiftUI

struct HomeScreen: View {
	private enum tabs: Hashable {
		case today, list
	}

    var body: some View {
		TabView {
TodayView()
				.tabItem {
					TodayViewLabel()
				}
				.tag(tabs.today)
			CalendarList()
				.tabItem {
					ListViewLabel()
				}
				.tag(tabs.list)
		} // TabView
    } // body
} // View

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

//
//  HomeScreen.swift
//  AudioDiary (iOS)
//
//  Created by Nicholas Parsons on 19/4/2022.
//

