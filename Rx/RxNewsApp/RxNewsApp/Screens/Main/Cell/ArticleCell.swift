import UIKit

final class ArticleCell: UITableViewCell {
	@IBOutlet private var titile: UILabel!
	@IBOutlet private var descr: UILabel!

	override func awakeFromNib() {
		super.awakeFromNib()
	}
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	func configure(title: String, descr: String) {
		self.titile.text = title
		self.descr.text = descr
	}
}
