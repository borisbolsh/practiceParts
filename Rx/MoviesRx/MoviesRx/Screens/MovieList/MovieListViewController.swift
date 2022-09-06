import UIKit

final class MovieListViewController: UIViewController {
	private let segmentControl = UISegmentedControl()
	private let tableView = UITableView()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground

		setupSubviews()
		setupConstraints()
		self.navigationItem.titleView = segmentControl
	}

	private func setupSubviews() {
		setupSegmentedControls()

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
