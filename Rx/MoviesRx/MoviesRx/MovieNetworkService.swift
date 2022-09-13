import Foundation

final class MovieNetworkService: MovieService {
	public static let shared = MovieNetworkService()
	private init() {}
	private let apiKey = "XXXXXX"
	private let baseAPIURL = "https://imdb-api.com/"
	private let urlSession = URLSession.shared

	func fetchMovies(from endpoint: Endpoint,
									 successHandler: @escaping ([Movie]) -> Void,
									 errorHandler: @escaping (Error) -> Void) {
		guard let urlComponents = URLComponents(string: "\(baseAPIURL)/API/\(endpoint.rawValue)/\(apiKey)") else {
			errorHandler(MovieError.invalidEndpoint)
			return
		}

		guard let url = urlComponents.url else {
			errorHandler(MovieError.invalidEndpoint)
			return
		}

		urlSession.dataTask(with: url) { (data, response, error) in
			if error != nil {
				self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
				return
			}

			guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
				self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
				return
			}

			guard let data = data else {
				self.handleError(errorHandler: errorHandler, error: MovieError.noData)
				return
			}

			do {
				let moviesResponse = try JSONDecoder().decode(MoviesResponse.self, from: data)
				DispatchQueue.main.async {
					successHandler(moviesResponse.items)
				}
			} catch {
				self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
			}
		}.resume()
	}



	func searchMovie(query: String,
									 successHandler: @escaping ([SearchResult]) -> Void,
									 errorHandler: @escaping (Error) -> Void) {
		guard let urlComponents = URLComponents(string: "\(baseAPIURL)/API/Search/\(apiKey)/\(query)") else {
			errorHandler(MovieError.invalidEndpoint)
			return
		}


		guard let url = urlComponents.url else {
			errorHandler(MovieError.invalidEndpoint)
			return
		}

		urlSession.dataTask(with: url) { (data, response, error) in
			if error != nil {
				self.handleError(errorHandler: errorHandler, error: MovieError.apiError)
				return
			}

			guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
				self.handleError(errorHandler: errorHandler, error: MovieError.invalidResponse)
				return
			}

			guard let data = data else {
				self.handleError(errorHandler: errorHandler, error: MovieError.noData)
				return
			}

			do {
				let moviesResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
				DispatchQueue.main.async {
					successHandler(moviesResponse.results)
				}
			} catch {
				self.handleError(errorHandler: errorHandler, error: MovieError.serializationError)
			}
		}.resume()
	}

	private func handleError(errorHandler: @escaping(_ error: Error) -> Void, error: Error) {
		DispatchQueue.main.async {
			errorHandler(error)
		}
	}
}
