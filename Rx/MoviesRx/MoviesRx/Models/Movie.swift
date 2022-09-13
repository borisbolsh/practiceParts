import Foundation

struct MoviesResponse: Decodable {
	let items: [Movie]
}

struct Movie: Decodable {
	let id: String
	let rank: String
	let title: String
	let fullTitle: String
	let year: String
	let image: String
	let crew: String
	let imDbRating: String
	let imDbRatingCount: String
	let releaseState: String?
}
