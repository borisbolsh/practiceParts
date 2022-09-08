import Foundation
import RxSwift
import RxCocoa

final class MovieListViewViewModel {
	private let movieService: MovieService
	private let disposeBag = DisposeBag()

	init(endpoint: Driver<Endpoint>, movieService: MovieService) {
			self.movieService = movieService
			endpoint
					.drive(onNext: { [weak self] (endpoint) in
							print(endpoint)
							self?.fetchMovies(endpoint: endpoint)
			}).disposed(by: disposeBag)
	}

}
