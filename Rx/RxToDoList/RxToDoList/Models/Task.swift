import Foundation

struct Task {
	let title: String
	let description: String
	let priority: Priority
}

enum Priority: Int {
	case high
	case medium
	case low
}
