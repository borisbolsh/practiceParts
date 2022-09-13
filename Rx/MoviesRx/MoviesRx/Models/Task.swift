import Foundation

struct SearchResponse: Decodable {
	let results: [SearchResult]
}

struct SearchResult: Decodable {
	let id: String
	let image: String
	let title: String
	let description: String
}
