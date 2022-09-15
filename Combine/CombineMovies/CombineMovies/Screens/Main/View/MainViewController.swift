import UIKit
import Combine

fileprivate enum Section {
		case main
}

final class MainViewController: UIViewController {
	private let tableView = UITableView()
	private var diffableDataSource: UITableViewDiffableDataSource<Section, Movie>?
	private var subscriptions = Set<AnyCancellable>()
	private let movieAPI = MovieNetworkService.shared
	private lazy var activityIndicator: UIActivityIndicatorView = {
			$0.hidesWhenStopped = true
			$0.center = self.view.center
			self.view.addSubview($0)
			return $0
	}(UIActivityIndicatorView(style: .large))
	var isFetchingData = CurrentValueSubject<Bool, Never>(false)

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Users"


		setupTableView()
		bindActivityIndicator()
		fetchMovies()
	}

	private func setupTableView() {
		view.addSubview(tableView)
		tableView.frame = view.bounds

		tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
		diffableDataSource = UITableViewDiffableDataSource<Section, Movie>(tableView: tableView) { (tableView, indexPath, movie) -> UITableViewCell? in
			let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
			cell.textLabel?.text = movie.title
			return cell
		}
	}

	private func bindActivityIndicator() {
		isFetchingData
			.assign(to: \UIActivityIndicatorView.combine_isAnimating, on: self.activityIndicator)
			.store(in: &subscriptions)
	}

	private func fetchMovies() {
		isFetchingData.value = true
		self.movieAPI.fetchMovies(from: .nowPlaying)
			.sink(receiveCompletion: {[unowned self] (completion) in
				if case let .failure(error) = completion {
					self.handleError(apiError: error)
				}
				self.isFetchingData.value = false
			}, receiveValue: { [unowned self] in self.generateSnapshot(with: $0)
			})
			.store(in: &self.subscriptions)
	}

	private func generateSnapshot(with movies: [Movie]) {
		var snapshot = NSDiffableDataSourceSnapshot<Section, Movie>()
		snapshot.appendSections([.main])
		snapshot.appendItems(movies)
		diffableDataSource?.apply(snapshot, animatingDifferences: true)
	}

	private func handleError(apiError: MovieStoreAPIError) {
		let alertController = UIAlertController(title: "Error", message: apiError.localizedDescription, preferredStyle: .alert)
		alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
		present(alertController, animated: true)
	}
}

private extension UIActivityIndicatorView {
	var combine_isAnimating: Bool  {
		set {
			if (newValue) {
				startAnimating()
			} else {
				stopAnimating()
			}
		}

		get {
			return isAnimating
		}
	}
}
