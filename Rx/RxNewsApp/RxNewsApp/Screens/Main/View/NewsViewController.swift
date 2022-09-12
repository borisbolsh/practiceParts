import UIKit
import RxSwift
import RxCocoa

final class NewsViewController: UIViewController {
	private var articles = [Article]()
	
	private let tableView = UITableView()
	private let disposeBag = DisposeBag()

	override func viewDidLoad() {
		super.viewDidLoad()
		view.addSubview(tableView)
		tableView.dataSource = self
		tableView.frame = view.bounds
		tableView.register(ArticleCell.self, forCellReuseIdentifier: String(describing: ArticleCell.self))
		populateNews()
	}

	private func populateNews() {
		let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=0cf790498275413a9247f8b94b3843fd")!

		let resource = Resource<ArticlesList>(url: url)

		URLRequest.load(resource: resource)
			.subscribe(onNext: { [weak self] result in
				if let result = result {
					self?.articles = result.articles
					DispatchQueue.main.async {
						self?.tableView.reloadData()
					}
				}
			}).disposed(by: disposeBag)
	}
}

extension NewsViewController: UITableViewDataSource {
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return articles.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ArticleCell.self), for: indexPath) as? ArticleCell else {
			fatalError("ArticleTableViewCell does not exist")
		}
		cell.configure(title: self.articles[indexPath.row].title,
									 descr: self.articles[indexPath.row].description)
		return cell
	}
}
