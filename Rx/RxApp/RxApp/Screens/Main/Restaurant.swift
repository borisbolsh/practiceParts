import Foundation

struct Restaurant: Decodable {
	var name: String
	let cuisine: Cuisine
}

enum Cuisine: String, Decodable {
	case european
	case indian
	case mexican
	case french
	case english
}
