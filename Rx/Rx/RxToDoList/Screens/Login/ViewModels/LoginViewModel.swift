import Foundation
import RxSwift

final class LoginViewModel {
	let usernameTextPublishSubject = PublishSubject<String>()
	let passwordTextPublishSubject = PublishSubject<String>()

	func isValid() -> Observable<Bool> {
		return Observable.combineLatest(usernameTextPublishSubject.asObserver(), passwordTextPublishSubject.asObserver().startWith("")).map { username, password in
			return username.count > 3 && password.count > 3
		}.startWith(false)
	}
}
