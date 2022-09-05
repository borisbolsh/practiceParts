import UIKit
import RxSwift
import RxCocoa

final class TasksListViewController: UIViewController {
	private let tableView = UITableView()
	private let segmentControl = UISegmentedControl()

	private var tasks = BehaviorRelay<[Task]>(value: [])
	private var filteredTasks = [Task]()

	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = Resources.Localization.TasksList.titlePage

		setupSubviews()
		setupConstraints()
	}

	private func setupSubviews() {
		setupSegmentedControls()
		setupRightBarButtons()

		tableView.delegate = self
		tableView.dataSource = self
		tableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))

		view.addSubview(segmentControl)
		view.addSubview(tableView)
	}

	private func setupSegmentedControls() {
		segmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.allPriorities,
			at: 0,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.highPriority,
			at: 1,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.mediumPriority,
			at: 2,
			animated: false
		)

		segmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.lowPriority,
			at: 3,
			animated: false
		)
		segmentControl.selectedSegmentIndex = 0
		segmentControl.addTarget(self,
														 action: #selector(segmentedControlValueChanged(_:)),
														 for: .valueChanged)
	}

	private func setupRightBarButtons() {
		let addButton = UIBarButtonItem(
			title: Resources.Localization.TasksList.rightBarBntString,
			style: .plain,
			target: self,
			action: #selector(addBtnTapped)
		)

		self.navigationItem.rightBarButtonItem = addButton
	}

	private func setupConstraints() {
		segmentControl.translatesAutoresizingMaskIntoConstraints = false
		tableView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			segmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			segmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			segmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

			tableView.topAnchor.constraint(equalTo: segmentControl.bottomAnchor),
			tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
			tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
			tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
		])
	}
}

extension TasksListViewController {
	@objc private func addBtnTapped() {
		let addVC = AddNewTaskViewController()
		addSubscribeTask(vc: addVC)

		let newNavVC = UINavigationController(rootViewController: addVC)
		navigationController?.present(newNavVC, animated: true, completion: nil)
	}

	@objc private func segmentedControlValueChanged(_ sender: UISegmentedControl) {
		let priority = Priority(rawValue: sender.selectedSegmentIndex - 1)
		filterTasks(by: priority)
	}

	private func addSubscribeTask(vc: AddNewTaskViewController) {
		vc.taskSubjectObservable
			.subscribe(onNext: { [unowned self] task in
				let priority = Priority(rawValue: self.segmentControl.selectedSegmentIndex - 1)

				var existingTasks = tasks.value
				existingTasks.append(task)
				self.tasks.accept(existingTasks)

				self.filterTasks(by: priority)

		}).disposed(by: disposeBag)
	}

	private func updateTableView() {
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

	private func filterTasks(by priority: Priority?) {
		if priority == nil {
			self.filteredTasks = self.tasks.value
			self.updateTableView()
		} else {
			self.tasks.map { tasks in
				return tasks.filter { $0.priority == priority }
			}.subscribe(onNext: { [weak self] tasks in
				self?.filteredTasks = tasks
				self?.updateTableView()
			}).disposed(by: disposeBag)
		}
	}
}

extension TasksListViewController: UITableViewDelegate, UITableViewDataSource {
	func numberOfSections(in tableView: UITableView) -> Int {
			return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return filteredTasks.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath)
		cell.textLabel?.text = filteredTasks[indexPath.row].title
		cell.detailTextLabel?.text = filteredTasks[indexPath.row].description
		return cell
	}
}
