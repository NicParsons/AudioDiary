import Foundation

struct Person: Codable, Identifiable, Hashable {
var id = UUID()
	var name = ""
}
