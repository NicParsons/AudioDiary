import SwiftUI

@main
struct AudioDiaryApp: App {
	@StateObject var model = Model()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView()
			HomeScreen()
				.environmentObject(model)
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
		.commands {
			PlaybackControlsMenu()
		}
    } // body
} // App

//  AudioDiaryApp.swift
//  Shared
//
//  Created by Nicholas Parsons on 16/4/2022.
//

