import UIKit

final class ViewController: UIViewController {
	private enum Constants {
		static let topInsetTimeLabel: CGFloat = 20
	}
	private let timeLabel = UILabel()
	private let startButton = UIButton()
	private let cancelButton = UIButton()
	private var timer = Timer()

	private var isTimerStarted = false
	private var time = 1500

	override func viewDidLoad() {
		super.viewDidLoad()
		setupSubviews()
		setupUI()
	}

	private func setupSubviews() {

	}

	private func setupUI() {
		view.addSubview(timeLabel)
		view.addSubview(startButton)
		view.addSubview(cancelButton)

		timeLabel.translatesAutoresizingMaskIntoConstraints = false
		startButton.translatesAutoresizingMaskIntoConstraints = false
		cancelButton.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			timeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
			timeLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.topInsetTimeLabel),

			cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
			cancelButton.rightAnchor.constraint(equalTo: startButton.leftAnchor, constant: -16),
			cancelButton.heightAnchor.constraint(equalToConstant: 56)

			startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
			startButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor)
		])
	}
}

// MARK: Actions

extension ViewController {}
