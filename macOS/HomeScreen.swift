import SwiftUI

struct HomeScreen: View {
	@SceneStorage("sidebarSelection") private var selection: SidebarItem?

    var body: some View {
		NavigationView {
			Sidebar(selected: $selection)
				.frame(minWidth: 250)
				.onAppear {
					if selection == nil { selection = .today }
				}

Text("Select an item from the sidebar.")
		} // NavigationView
    } // body
} // View

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}

//
//  HomeScreen.swift
//  AudioDiary (macOS)
//
//  Created by Nicholas Parsons on 18/4/2022.
//

