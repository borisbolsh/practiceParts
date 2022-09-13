import Foundation

protocol MovieService {
	func fetchMovies(from endpoint: Endpoint, successHandler: @escaping (_ response: [Movie]) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
	func searchMovie(query: String, successHandler: @escaping (_ response: [SearchResult]) -> Void, errorHandler: @escaping(_ error: Error) -> Void)
}

public enum Endpoint: String, CustomStringConvertible, CaseIterable {
	case nowPlaying = "InTheaters"
	case upcoming = "ComingSoon"
	case popular = "MostPopularMovies"
	case top250 = "Top250Movies"

	public var description: String {
		switch self {
		case .nowPlaying: return "Now"
		case .upcoming: return "Upcoming"
		case .popular: return "Popular"
		case .top250: return "Top250"
		}
	}

	public init?(index: Int) {
		switch index {
		case 0: self = .nowPlaying
		case 1: self = .popular
		case 2: self = .upcoming
		case 3: self = .top250
		default: return nil
		}
	}

	public init?(description: String) {
		guard let first = Endpoint.allCases.first(where: { $0.description == description }) else {
			return nil
		}
		self = first
	}
}

public enum MovieError: Error {
	case apiError
	case invalidEndpoint
	case invalidResponse
	case noData
	case serializationError
}
