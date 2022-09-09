import Foundation

final class MovieNetworkService: MovieService {
	public static let shared = MovieNetworkService()
	private init() {}
	private let apiKey = "XXXXXXXX"
	private let baseAPIURL = "https://imdb-api.com/"
	private let urlSession = URLSession.shared

	func fetchMovies(from endpoint: Endpoint, params: [String : String]?, successHandler: @escaping (Bool) -> Void, errorHandler: @escaping (Error) -> Void) {
	}

	func fetchMovie(id: Int, successHandler: @escaping (Movie) -> Void, errorHandler: @escaping (Error) -> Void) {
	}

	func searchMovie(query: String, params: [String : String]?, successHandler: @escaping (Movie) -> Void, errorHandler: @escaping (Error) -> Void) {
	}
}
