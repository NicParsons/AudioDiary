import SwiftUI
import UniformTypeIdentifiers

struct ImportButton: View {
	@EnvironmentObject var model: Model
	@State private var showImporter = false
	@State private var alertIsShowing = false
	@State private var error: Error?
    var body: some View {
        Button(
			action: { showImporter = true }) {
				Label("Import Audio Files", systemImage: "square.and.arrow.down")
			} // Button
			.fileImporter(isPresented: $showImporter,
						  allowedContentTypes: [UTType.audio],
			allowsMultipleSelection: true) { result in
				switch result {
				case .success(let urls):
					for url in urls {
					do {
					try model.importRecording(url)
					} catch {
						self.error = error
alertIsShowing = true
					} // do try catch
					} // loop
				case .failure(let importError):
					self.error = importError
alertIsShowing = true
				} // Switch
			} // completion handler
						  .alert("Unable to import your file.",
								 isPresented: $alertIsShowing) {
							  Button("OK") {
								  // do nothing, I guess
							  }
						  } message: {
							  Text(error?.localizedDescription ?? "Please contact the developer with as much detail about the issue as you can.")
						  }
    } // body
} // view

struct ImportButton_Previews: PreviewProvider {
    static var previews: some View {
        ImportButton()
			.environmentObject(Model())
    }
}


//  ImportButton.swift
//  AudioDiary
//  Created by Nicholas Parsons on 22/4/2022.
