import Foundation

extension Model {
	func dummyURL() -> URL {
	let fileManager = 		FileManager.default
	let documentDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
	   let directoryContents = try! fileManager.contentsOfDirectory(at: documentDirectory, includingPropertiesForKeys: nil)
return directoryContents[0]
	}
}
