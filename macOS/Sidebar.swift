import SwiftUI

enum SidebarItem: String, Hashable, CaseIterable {
	case today, list
}

struct Sidebar: View {
	@Binding var selected: SidebarItem?

    var body: some View {
		List {
NavigationLink(
	destination: TodayView(),
	tag: .today,
selection: $selected
) {
	TodayViewLabel()
} // NavigationLink

			NavigationLink(
				destination: CalendarList(),
				tag: .list,
				selection: $selected
			) {
				ListViewLabel()
			} // NavigationLink
		} // List
		.listStyle(.sidebar)
    } // body
} // View

struct Sidebar_Previews: PreviewProvider {
    static var previews: some View {
		Sidebar(selected: .constant(.today))
    }
}

//
//  Sidebar.swift
//  AudioDiary (macOS)
//
//  Created by Nicholas Parsons on 18/4/2022.
//

