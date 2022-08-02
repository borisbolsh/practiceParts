import UIKit

final class ViewController: UIViewController {
	private enum Constants {
		static let topInsetTimeLabel: CGFloat = 20

		enum CancelBtn {
			static let height: CGFloat = 56
			static let leftInset: CGFloat = 16
			static let bottomInset: CGFloat = -16
			static let rightInset: CGFloat = -16
		}

		enum StartBtn {
			static let bottomInset: CGFloat = -16
			static let rightInset: CGFloat = -16
		}
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
		timeLabel.text = "25:00"
		
		startButton.backgroundColor = .black
		startButton.setTitle("Start", for: .normal)
		startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)

		cancelButton.backgroundColor = .black
		cancelButton.setTitle("Cancel", for: .normal)
		cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
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

			cancelButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.CancelBtn.leftInset),
			cancelButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.CancelBtn.bottomInset),
			cancelButton.rightAnchor.constraint(equalTo: startButton.leftAnchor, constant: Constants.CancelBtn.rightInset),
			cancelButton.heightAnchor.constraint(equalToConstant: Constants.CancelBtn.height),

			startButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.StartBtn.rightInset),
			startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.StartBtn.bottomInset),
			startButton.heightAnchor.constraint(equalTo: cancelButton.heightAnchor),
			startButton.widthAnchor.constraint(equalTo: cancelButton.widthAnchor)
		])
	}
}

// MARK: Actions

extension ViewController {
	@objc
	private func startButtonTapped() {
		print("startButtonTapped")
	}

	@objc
	private func cancelButtonTapped() {
		print("cancelButtonTapped")
	}
}
