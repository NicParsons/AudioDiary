import SwiftUI

@main
struct AudioDiaryApp: App {
	@StateObject var audioRecorder = AudioRecorder()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView()
			#if os(macOS)
			HomeScreen()
				.environmentObject(audioRecorder)
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
			#else
			TodayView()
				.environmentObject(audioRecorder)
				.environment(\.managedObjectContext, persistenceController.container.viewContext)
			#endif
        }
    }
}

//
//  AudioDiaryApp.swift
//  Shared
//
//  Created by Nicholas Parsons on 16/4/2022.
//

