import UIKit

final class MainTabController: UITabBarController {
	private enum Constants {
		static let sizeImageInTabBar: CGFloat = 28
	}

	override func viewDidLoad() {
		super.viewDidLoad()
		configureViewControllers()
		self.tabBar.backgroundColor = .white.withAlphaComponent(0.8)
	}

	private func configureViewControllers() {
		let moviesList = MovieListViewController()
		let nav1 = templateNavigationController(image: UIImage(named: "star"), title: "Movies", tagTabInt: 0, rootViewController: moviesList)

		let search = MovieSearchViewController()
		let nav2 = templateNavigationController(image: UIImage(named: "search"), title: "Search", tagTabInt: 1, rootViewController: search)
		nav2.navigationBar.prefersLargeTitles = true

		viewControllers = [nav1, nav2]
	}

	private func templateNavigationController(image: UIImage?, title: String, tagTabInt: Int, rootViewController: UIViewController) -> UINavigationController {
		let imageNew = image?.resizeImage(image: image ?? UIImage(), targetSize: CGSize(width: Constants.sizeImageInTabBar, height: Constants.sizeImageInTabBar))
		let nav = UINavigationController(rootViewController: rootViewController)
		nav.tabBarItem = UITabBarItem(title: title, image: imageNew, tag: tagTabInt)
		nav.navigationBar.barTintColor = .white
		return nav
	}
}
