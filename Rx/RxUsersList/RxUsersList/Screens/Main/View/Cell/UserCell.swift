import UIKit

protocol UserCellViewInput {
	func configure(model: UserDetailModel)
}

final class UserCell: UITableViewCell {
	static let starTintColor = UIColor(red: 212/255, green: 163/255, blue: 50/255, alpha: 1.0)

	private let userName = UILabel()
	private let favoriteImage = UIImageView()

	override func awakeFromNib() {
		super.awakeFromNib()
		setupSubviews()
		setupConstraints()
	}

	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)
	}

	private func setupSubviews() {
//		userName.text = nil

		self.addSubview(userName)
		self.addSubview(favoriteImage)
	}

	private func setupConstraints() {
		userName.translatesAutoresizingMaskIntoConstraints = false
		favoriteImage.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			userName.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			userName.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
			userName.rightAnchor.constraint(greaterThanOrEqualTo: favoriteImage.leftAnchor, constant: -16),

			favoriteImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
			favoriteImage.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
			favoriteImage.heightAnchor.constraint(equalToConstant: 16),
			favoriteImage.widthAnchor.constraint(equalToConstant: 16),
		])
	}
}

extension UserCell: UserCellViewInput {
	func configure(model: UserDetailModel) {
		userName.text = model.userData.first_name ?? ""
		if model.isFavorite.value {
			favoriteImage.image = UIImage(systemName: "star.fill")?.withTintColor(UserCell.starTintColor)
		} else {
			favoriteImage.image = UIImage(systemName: "star")?.withTintColor(UserCell.starTintColor)
		}
	}
}
