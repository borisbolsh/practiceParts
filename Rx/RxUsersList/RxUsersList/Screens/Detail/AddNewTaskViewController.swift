import UIKit
import RxSwift

final class AddNewTaskViewController: UIViewController {
	private let prioritySegmentControl = UISegmentedControl()
	private let taskTitleTextField = UITextField()
	private let taskDescrTextField = UITextField()

	private let taskSubject = PublishSubject<Task>()

	var taskSubjectObservable: Observable<Task> {
			return taskSubject.asObservable()
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		view.backgroundColor = .systemBackground
		title = Resources.Localization.AddTask.titlePage

		setupSubviews()
		setupConstraints()
	}

	private func setupSubviews() {
		setupSegmentedControls()
		setupRightBarButtons()

		taskTitleTextField.text = nil
		taskTitleTextField.placeholder = Resources.Localization.AddTask.titleTextFieldPlaceholder
		taskTitleTextField.borderStyle = .roundedRect
		taskTitleTextField.delegate = self

		taskDescrTextField.text = nil
		taskDescrTextField.placeholder = Resources.Localization.AddTask.descrTextFieldPlaceholder
		taskDescrTextField.borderStyle = .roundedRect
		taskDescrTextField.delegate = self

		view.addSubview(prioritySegmentControl)
		view.addSubview(taskTitleTextField)
		view.addSubview(taskDescrTextField)
	}

	private func setupSegmentedControls() {
		prioritySegmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.highPriority,
			at: 0,
			animated: false
		)

		prioritySegmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.mediumPriority,
			at: 1,
			animated: false
		)

		prioritySegmentControl.insertSegment(
			withTitle: Resources.Localization.TasksSegmentControl.lowPriority,
			at: 2,
			animated: false
		)
		prioritySegmentControl.selectedSegmentIndex = 0
	}

	private func setupRightBarButtons() {
		let addButton = UIBarButtonItem(
			title: Resources.Localization.AddTask.rightBarBntString,
			style: .plain,
			target: self,
			action: #selector(saveBtnTapped)
		)

		self.navigationItem.rightBarButtonItem = addButton
	}

	private func setupConstraints() {
		prioritySegmentControl.translatesAutoresizingMaskIntoConstraints = false
		taskTitleTextField.translatesAutoresizingMaskIntoConstraints = false
		taskDescrTextField.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			prioritySegmentControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
			prioritySegmentControl.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			prioritySegmentControl.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

			taskTitleTextField.topAnchor.constraint(equalTo: prioritySegmentControl.bottomAnchor, constant: 80),
			taskTitleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			taskTitleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			taskTitleTextField.heightAnchor.constraint(equalToConstant: 48),

			taskDescrTextField.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: 16),
			taskDescrTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			taskDescrTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			taskDescrTextField.heightAnchor.constraint(equalToConstant: 48),
		])
	}
}

extension AddNewTaskViewController {
	@objc private func saveBtnTapped() {
		guard
			let priority = Priority(rawValue: prioritySegmentControl.selectedSegmentIndex),
			let title = taskTitleTextField.text,
			let descr = taskDescrTextField.text,
			title != "" && descr != ""
		else {
			return
		}

		let task = Task(title: title, description: descr, priority: priority)
		taskSubject.onNext(task)

		self.dismiss(animated: true, completion: nil)
	}
}

extension AddNewTaskViewController: UITextFieldDelegate {
	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		self.view.endEditing(true)
		return false
	}
}
