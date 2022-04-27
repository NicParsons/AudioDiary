import SwiftUI

struct HomeScreen: View {
	@SceneStorage("selectedTab") private var selectedTab: tabs = tabs.today
	private enum tabs: String, Hashable {
		case today, list
	}

    var body: some View {
		TabView(selection: $selectedTab) {
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

