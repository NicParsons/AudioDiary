import SwiftUI
import CoreData

struct ContentView: View {

    var body: some View {
        NavigationView {
            List {
                }
            }
            .toolbar {
#if os(iOS)
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
#endif
                ToolbarItem {
                    Button(action: addEntry) {
                        Label("Add", systemImage: "plus")
                    }
                }
            }
            Text("Select a diary entry.")
        }
    }

    private func addEntry() {
        withAnimation {

        }
    }

