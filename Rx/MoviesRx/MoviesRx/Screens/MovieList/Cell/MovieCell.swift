import UIKit
import Kingfisher

protocol MovieCellInput {
	func configure(viewModel: MovieViewModel)
}

final class MovieCell: UITableViewCell {
	private let posterImageView = UIImageView()
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let releaseDateLabel = UILabel()
	private let ratingLabel = UILabel()

	override init(style: CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		configureUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
		setupConstraints()
		configureUI()
	}

	private func setupUI() {
//		contentView.addSubview(launchView)
//		launchView.addSubview(titleLabel)
//		launchView.addSubview(dateLabel)
//		launchView.addSubview(statusImageView)
	}

	private func setupConstraints() {
//		launchView.translatesAutoresizingMaskIntoConstraints = false
//		titleLabel.translatesAutoresizingMaskIntoConstraints = false
//		dateLabel.translatesAutoresizingMaskIntoConstraints = false
//		statusImageView.translatesAutoresizingMaskIntoConstraints = false
//
//		NSLayoutConstraint.activate ([
//			launchView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: Constants.LaunchView.insetBottom),
//			launchView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: Constants.LaunchView.insetLeft),
//			launchView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: Constants.LaunchView.insetRight),
//			launchView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constants.LaunchView.insetTop),
//			launchView.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.LaunchView.heightItem),
//
//			titleLabel.topAnchor.constraint(equalTo: launchView.topAnchor, constant: Constants.TitleLabel.insetTop),
//			titleLabel.leftAnchor.constraint(equalTo: launchView.leftAnchor, constant: Constants.TitleLabel.insetLeft),
//			titleLabel.rightAnchor.constraint(equalTo:  statusImageView.leftAnchor, constant: Constants.TitleLabel.insetRight),
//			titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: Constants.TitleLabel.height),
//
//			dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
//			dateLabel.leftAnchor.constraint(equalTo: launchView.leftAnchor, constant: Constants.DateLabel.insetLeft),
//			dateLabel.rightAnchor.constraint(equalTo:  statusImageView.leftAnchor, constant: Constants.DateLabel.insetRight),
//			dateLabel.bottomAnchor.constraint(equalTo: launchView.bottomAnchor, constant: Constants.DateLabel.insetBottom),
//
//			statusImageView.centerYAnchor.constraint(equalTo: launchView.centerYAnchor),
//			statusImageView.rightAnchor.constraint(equalTo: launchView.rightAnchor, constant: Constants.StatusImageView.insetRight),
//			statusImageView.widthAnchor.constraint(equalToConstant: Constants.StatusImageView.width),
//			statusImageView.heightAnchor.constraint(equalToConstant: Constants.StatusImageView.height),
//		])
	}

	private func configureUI() {
//		self.backgroundColor = .clear
//		contentView.backgroundColor = .clear
//		launchView.backgroundColor = Resourses.Colors.secondaryBackground
//
//		launchView.layer.cornerRadius = Constants.LaunchView.cornerRadius
//
//		titleLabel.font = Resourses.Fonts.detailsLaunchesTitle
//		titleLabel.textColor = Resourses.Colors.lightText
//		dateLabel.textColor = Resourses.Colors.secondaryText
	}
}

extension MovieCell: MovieCellInput {
	func configure(viewModel: MovieViewModel) {
//		titleLabel.text = viewModel.title
//		overviewLabel.text = viewModel.overview
//		releaseDateLabel.text = viewModel.releaseDate
//		ratingLabel.text = viewModel.rating
//		posterImageView.kf.setImage(with: viewModel.posterURL)
	}
}
