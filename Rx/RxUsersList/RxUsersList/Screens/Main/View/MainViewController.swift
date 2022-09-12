import UIKit
import RxSwift
import RxCocoa

final class MainViewController: UIViewController {
	@IBOutlet private var searchTextField: UITextField!
	@IBOutlet private var tableView: UITableView!

	let userViewModelInstance = UserViewModel()
	let userList = BehaviorRelay<[UserDetailModel]>(value: [])
	let filteredList = BehaviorRelay<[UserDetailModel]>(value: [])
	var controller: UserDetailViewController?

	private let disposeBag = DisposeBag()

	init(controller: UserDetailViewController = UserDetailViewController()) {
		self.controller = controller
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		self.title = "Users"
		userViewModelInstance.fetchUserList()
		setupSubviews()
		bindUI()
	}

	private func setupSubviews() {
		tableView.register(UserCell.self, forCellReuseIdentifier: String(describing: UserCell.self))
	}

	func bindUI() {
		userViewModelInstance.userViewModelObserver.subscribe(onNext: { (value) in
				self.filteredList.accept(value)
				self.userList.accept(value)
		},onError: { error in
				self.errorAlert()
		}).disposed(by: disposeBag)

		tableView.tableFooterView = UIView()

		filteredList.bind(to: tableView.rx.items(
			cellIdentifier: String(describing: UserCell.self),
			cellType: UserCell.self)
		) { row, model, cell in
				cell.configure(model: model)
		}.disposed(by: disposeBag)

		tableView.rx.itemSelected.subscribe(onNext: { (indexPath) in
				self.tableView.deselectRow(at: indexPath, animated: true)
				self.controller?.userDetail.accept(self.filteredList.value[indexPath.row])
				self.controller?.userDetail.value.isFavObservable.subscribe(onNext: { _ in
						self.tableView.reloadData()
				}).disposed(by: self.disposeBag)
				self.navigationController?.pushViewController(self.controller ?? UserDetailViewController(), animated: true)
		}).disposed(by: disposeBag)

		Observable.combineLatest(userList.asObservable(), searchTextField.rx.text, resultSelector: { users, search in
			return users.filter { (user) -> Bool in
				self.filterUserList(userModel: user, searchText: search)
			}
		}).bind(to: filteredList).disposed(by: disposeBag)
	}

	//Search function
	func filterUserList(userModel: UserDetailModel,
											searchText: String?) -> Bool {
			if let search = searchText,
					!search.isEmpty,
					!(userModel.userData.first_name?.contains(search) ?? false) {
					return false
			}
			return true
	}

	func errorAlert() {
		let alert = UIAlertController(title: "Error",
																	message: "Check your Internet connection and Try Again!",
																	preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Ok",
																	style: .cancel,
																	handler: nil))
		self.present(alert, animated: true, completion: nil)
	}
}
