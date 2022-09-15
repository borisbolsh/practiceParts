import Foundation

struct SearchResultViewModel {
	private var movie: SearchResult

	init(movie: SearchResult) {
		self.movie = movie
	}

	var title: String {
		return movie.title
	}

	var posterURL: String {
		return movie.image
	}

	var releaseDate: String {
		return movie.description
	}
}
