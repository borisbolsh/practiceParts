import UIKit
import RxCocoa
import RxSwift

final class MovieListViewController: UIViewController {
	private let segmentControl = UISegmentedControl()
	private let tableView = UITableView()

//	private var movieListViewViewModel: MovieListViewViewModel!
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		setupSubviews()
		setupConstraints()
		self.navigationItem.titleView = segmentControl
	}

	private func setupSubviews() {
		setupSegmentedControls()
		setupTableView()

		view.addSubview(tableView)
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
		segmentControl.selectedSegmentIndex = 0
	}

	private func setupTableView() {
		tableView.delegate = self
		tableView.dataSource = self
		tableView.rowHeight = MovieCell.cellHeight
		tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
	}
	
	private func setupConstraints() {
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			tableView.topAnchor.constraint(equalTo: view.topAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
		])
	}
}

extension MovieListViewController: UITableViewDelegate {

}

extension MovieListViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 5
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: MovieCell.self), for: indexPath)
		return cell
	}
}
