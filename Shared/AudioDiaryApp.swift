import SwiftUI

@main
struct AudioDiaryApp: App {
	@StateObject var audioRecorder = AudioRecorder()
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            // ContentView()
			TodayView()
				.environmentObject(audioRecorder)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

//
//  AudioDiaryApp.swift
//  Shared
//
//  Created by Nicholas Parsons on 16/4/2022.
//

