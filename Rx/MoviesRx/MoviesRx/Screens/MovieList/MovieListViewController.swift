import UIKit
import RxCocoa
import RxSwift

final class MovieListViewController: UIViewController {
	private let segmentControl = UISegmentedControl()
	private let tableView = UITableView()
	private let activityIndicatorView = UIActivityIndicatorView()
	private let infoLabel = UILabel()

	private var movieListViewViewModel: MovieListViewViewModel?
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		setupSubviews()
		setupConstraints()
		self.navigationItem.titleView = segmentControl
		setupListViewModel()
	}

	private func setupListViewModel() {
		movieListViewViewModel = MovieListViewViewModel(endpoint: segmentControl.rx.selectedSegmentIndex
				.map { Endpoint(index: $0) ?? .nowPlaying }
				.asDriver(onErrorJustReturn: .nowPlaying)
				, movieService: MovieNetworkService.shared)

		movieListViewViewModel?.movies.drive(onNext: {[unowned self] (_) in
				self.tableView.reloadData()
		}).disposed(by: disposeBag)

		movieListViewViewModel?.isFetching.drive(activityIndicatorView.rx.isAnimating)
				.disposed(by: disposeBag)

		movieListViewViewModel?.error.drive(onNext: {[unowned self] (error) in
				self.infoLabel.isHidden = !(self.movieListViewViewModel?.hasError ?? true)
				self.infoLabel.text = error
		}).disposed(by: disposeBag)
	}

	private func setupSubviews() {
		setupSegmentedControls()
		setupTableView()

		infoLabel.numberOfLines = 0
		activityIndicatorView.isHidden = true
		view.addSubview(tableView)
		view.addSubview(activityIndicatorView)
		view.addSubview(infoLabel)
	}

	private func setupSegmentedControls() {
		segmentControl.insertSegment(
			withTitle: Resources.Localization.MovieListSegmentControl.new,
			at: 0,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.MovieListSegmentControl.popular,
			at: 1,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.MovieListSegmentControl.upcoming,
			at: 2,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.MovieListSegmentControl.top250,
			at: 3,
			animated: false
		)

		segmentControl.selectedSegmentIndex = 0
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = MovieCell.cellHeight
		tableView.estimatedRowHeight = 100
		tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
	}
	
	private func setupConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false
		activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

			activityIndicatorView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			activityIndicatorView.centerYAnchor.constraint(equalTo: view.centerYAnchor),

			infoLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			infoLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
			infoLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			infoLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16)
		])
	}
}

extension MovieListViewController: UITableViewDelegate {

}

extension MovieListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movieListViewViewModel?.numberOfMovies ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell
		if let viewModel = movieListViewViewModel?.viewModelForMovie(at: indexPath.row) {
			cell?.configure(viewModel: viewModel)
		}
		return cell ?? UITableViewCell()
	}
}
