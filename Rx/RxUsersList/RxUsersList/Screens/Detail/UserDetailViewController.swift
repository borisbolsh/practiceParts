import UIKit
import RxSwift
import RxCocoa

final class UserDetailViewController: UIViewController {
	@IBOutlet private var idNo: UILabel!
	@IBOutlet private var fullName: UILabel!
	@IBOutlet private var email: UILabel!
	@IBOutlet private var favoriteButton: UIButton!

	private let disposeBag = DisposeBag()
	var userDetail = BehaviorRelay<UserDetailModel>(value: UserDetailModel())
	var userDetailObserver: Observable<UserDetailModel> {
			return userDetail.asObservable()
	}

	override func viewDidLoad() {
		super.viewDidLoad()

		favoriteButton.rx.tap.bind {
			let favValue = self.userDetail.value.isFavorite
			favValue.accept(!favValue.value)
		}.disposed(by: disposeBag)

		userDetailObserver.subscribe(onNext: { (userValue) in
			self.title = "\(userValue.userData.first_name ?? "")'s Details"
			self.idNo.text = "\(userValue.userData.id ?? 0)"
			self.fullName.text = "\(userValue.userData.first_name ?? "") \(userValue.userData.last_name ?? "")"
			self.email.text = "\(userValue.userData.email ?? "")"
			self.setupFavoriteButtonImage(userValue: userValue)
			userValue.isFavObservable.subscribe(onNext: { (value) in
				self.setupFavoriteButtonImage(userValue: userValue)
			}).disposed(by: self.disposeBag)
		}).disposed(by: disposeBag)
	}

	func setupFavoriteButtonImage(userValue: UserDetailModel) {
		if userValue.isFavorite.value {
			favoriteButton.setImage(UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor), for: .normal)
		} else{
			favoriteButton.setImage(UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor), for: .normal)
		}
	}
}
