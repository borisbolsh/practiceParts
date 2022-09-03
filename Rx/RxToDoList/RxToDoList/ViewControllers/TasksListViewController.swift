import UIKit
import RxSwift

final class TasksListViewController: UIViewController {
	private let tableView = UITableView()
	private let segmentControl = UISegmentedControl()

	override func viewDidLoad() {
		super.viewDidLoad()

		view.backgroundColor = .systemBackground
		title = "ToDoList"
		setupSubviews()
		setupConstraints()
	}

	private func setupSubviews() {
		segmentControl.insertSegment(
			withTitle: Resources.Loacalization.TasksSegmentControl.highPriority,
			at: 0,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Loacalization.TasksSegmentControl.mediumPriority,
			at: 1,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Loacalization.TasksSegmentControl.lowPriority,
			at: 2,
			animated: false
		)

		tableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))

		view.addSubview(segmentControl)
		view.addSubview(tableView)
	}

	private func setupConstraints() {
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor),
			segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor),

			tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath)
		return cell
	}
}
