import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
	var window: UIWindow?

	func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
		guard let scene = (scene as? UIWindowScene) else { return }

//		let vc = TasksListViewController()
//		let vc = MainTabController()
//		let navVC = UINavigationController(rootViewController: vc)

		window = .init(windowScene: scene)
		window?.rootViewController = MainTabController()
		window?.makeKeyAndVisible()
	}
}

