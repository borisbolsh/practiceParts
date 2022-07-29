import UIKit

final class ViewController: UIViewController {
	private let label = UILabel()
	private let button = UIButton()
	private let button2 = UIButton()

	override func viewDidLoad() {
		super.viewDidLoad()
		setupUI()
	}

	private func setupUI() {
		view.addSubview(label)
		view.addSubview(button)
		view.addSubview(button2)
	}
}
