import Foundation

struct MovieViewModel {
	private var movie: Movie

	init(movie: Movie) {
		self.movie = movie
	}

	var title: String {
		return movie.title
	}

	var overview: String {
		return movie.fullTitle
	}

	var posterURL: String {
		return movie.image
	}

	var releaseDate: String {
		return movie.releaseState != nil ? movie.releaseState ?? ""  : movie.year
	}

	var rating: String {
		let rating = Int(movie.imDbRating) ?? 0
		let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
			return acc + "⭐️"
		}
		return ratingText
	}
}
