import UIKit
import RxSwift
import RxCocoa

final class LoginViewController: UIViewController {
	@IBOutlet private var usernameTextField: UITextField!
	@IBOutlet private var passwordTextField: UITextField!
	@IBOutlet private var loginBtn: UIButton!

	private let loginViewModel: LoginViewModel
	private let disposeBag = DisposeBag()

	init(loginViewModel: LoginViewModel = LoginViewModel()) {
		self.loginViewModel = loginViewModel
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		usernameTextField.becomeFirstResponder()

		usernameTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.usernameTextPublishSubject).disposed(by: disposeBag)
		passwordTextField.rx.text.map { $0 ?? "" }.bind(to: loginViewModel.passwordTextPublishSubject).disposed(by: disposeBag)

		loginViewModel.isValid().bind(to: loginBtn.rx.isEnabled).disposed(by: disposeBag)
		loginViewModel.isValid().map { $0 ? 1 : 0.1 }.bind(to: loginBtn.rx.alpha).disposed(by: disposeBag)
	}

	@IBAction func loginBtnTapped(_ sender: UIButton) {
		print("login tapped")
	}
}

extension LoginViewController {

}
