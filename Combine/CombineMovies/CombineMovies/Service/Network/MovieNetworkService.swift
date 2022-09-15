import Foundation
import Combine

final class MovieNetworkService: MovieService {
	public static let shared = MovieNetworkService()
	private init() {}
	private let apiKey = "XXXXXXXX"
	private let baseAPIURL = "https://imdb-api.com"
	private let urlSession = URLSession.shared
	private var subscriptions = Set<AnyCancellable>()

	func fetchMovies(from endpoint: Endpoint) -> Future<[Movie], MovieStoreAPIError> {
		return Future<[Movie], MovieStoreAPIError> { [unowned self] promise in
			guard let urlComponents = URLComponents(string: "\(baseAPIURL)/API/\(endpoint.rawValue)/\(apiKey)") else {
				return promise(.failure(.urlError(URLError(URLError.unsupportedURL))))
			}

		guard let url = urlComponents.url else {
			return promise(.failure(.genericError))
		}

			self.urlSession.dataTaskPublisher(for: url)
					.tryMap { (data, response) -> Data in
							guard let httpResponse = response as? HTTPURLResponse, 200...299 ~= httpResponse.statusCode else {
									throw MovieStoreAPIError.responseError((response as? HTTPURLResponse)?.statusCode ?? 500)
							}
							return data
			}
			.decode(type: MoviesResponse.self, decoder: JSONDecoder())
			.receive(on: RunLoop.main)
			.sink(receiveCompletion: { (completion) in
					if case let .failure(error) = completion {
							switch error {
							case let urlError as URLError:
									promise(.failure(.urlError(urlError)))
							case let decodingError as DecodingError:
									promise(.failure(.decodingError(decodingError)))
							case let apiError as MovieStoreAPIError:
									promise(.failure(apiError))
							default:
									promise(.failure(.genericError))
							}
					}
			}, receiveValue: { promise(.success($0.items)) })
					.store(in: &self.subscriptions)
		}
	}
}
