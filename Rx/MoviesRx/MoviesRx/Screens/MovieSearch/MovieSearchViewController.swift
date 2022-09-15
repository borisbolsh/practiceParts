import UIKit
import RxCocoa
import RxSwift

final class MovieSearchViewController: UIViewController {
	private let tableView = UITableView()
	private let activityIndicatorView = UIActivityIndicatorView()
	private let infoLabel = UILabel()

	private var movieSearchViewViewModel: SearchMoviesViewModel?
	private let disposeBag = DisposeBag()
	private var searchBar: UISearchBar?

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		self.title = "Search"
		setupNavigationBar()
		setupSubviews()
		setupConstraints()
		setupListViewModel()
	}

	private func setupNavigationBar() {
		navigationItem.searchController = UISearchController(searchResultsController: nil)
		self.definesPresentationContext = true
		navigationItem.searchController?.dimsBackgroundDuringPresentation = false
		navigationItem.searchController?.hidesNavigationBarDuringPresentation = false

		navigationItem.searchController?.searchBar.sizeToFit()
		navigationItem.hidesSearchBarWhenScrolling = false
		navigationController?.navigationBar.prefersLargeTitles = true
	}

	private func setupListViewModel() {
		guard
			let searchBar = self.navigationItem.searchController?.searchBar
		else {
			return
		}
		movieSearchViewViewModel = SearchMoviesViewModel(query: searchBar.rx.text.orEmpty.asDriver(), movieService: MovieNetworkService.shared)

		movieSearchViewViewModel?.movies.drive(onNext: { [unowned self] (_) in
				self.tableView.reloadData()
		}).disposed(by: disposeBag)

		movieSearchViewViewModel?.isFetching.drive(activityIndicatorView.rx.isAnimating)
				.disposed(by: disposeBag)

		movieSearchViewViewModel?.info.drive(onNext: { [unowned self] (info) in
			self.infoLabel.isHidden = !(self.movieSearchViewViewModel?.hasInfo ?? false)
				self.infoLabel.text = info
		}).disposed(by: disposeBag)

		searchBar.rx.searchButtonClicked
				.asDriver(onErrorJustReturn: ())
				.drive(onNext: { [unowned searchBar] in
						searchBar.resignFirstResponder()
				}).disposed(by: disposeBag)

		searchBar.rx.cancelButtonClicked
				.asDriver(onErrorJustReturn: ())
				.drive(onNext: { [unowned searchBar] in
						searchBar.resignFirstResponder()
				}).disposed(by: disposeBag)

	}

	private func setupSubviews() {
		setupTableView()

		infoLabel.numberOfLines = 0
		activityIndicatorView.isHidden = true
		view.addSubview(tableView)
		view.addSubview(activityIndicatorView)
		view.addSubview(infoLabel)
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

extension MovieSearchViewController: UITableViewDelegate {

}

extension MovieSearchViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return movieSearchViewViewModel?.numberOfMovies ?? 0
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath) as? MovieCell
		if let viewModel = movieSearchViewViewModel?.viewModelForMovie(at: indexPath.row) {
			cell?.configure(viewModel: viewModel)
		}
		return cell ?? UITableViewCell()
	}
}
