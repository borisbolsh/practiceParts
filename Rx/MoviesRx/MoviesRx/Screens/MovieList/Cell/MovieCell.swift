import UIKit
import Kingfisher

protocol MovieCellInput {
	func configure(viewModel: MovieViewModel)
	func configure(viewModel: SearchResultViewModel)
}

final class MovieCell: UITableViewCell {
	static let cellHeight: CGFloat = 148

	private let posterImageView = UIImageView()
	private let titleLabel = UILabel()
	private let overviewLabel = UILabel()
	private let releaseDateLabel = UILabel()
	private let ratingLabel = UILabel()

	override init(style: CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		setupUI()
		setupConstraints()
		configureUI()
	}

	required init?(coder: NSCoder) {
		super.init(coder: coder)
		setupUI()
		setupConstraints()
		configureUI()
	}

	private func setupUI() {
		contentView.addSubview(posterImageView)
		contentView.addSubview(titleLabel)
		contentView.addSubview(overviewLabel)
		contentView.addSubview(releaseDateLabel)
		contentView.addSubview(ratingLabel)
	}

	private func setupConstraints() {
		posterImageView.translatesAutoresizingMaskIntoConstraints = false
		titleLabel.translatesAutoresizingMaskIntoConstraints = false
		overviewLabel.translatesAutoresizingMaskIntoConstraints = false
		releaseDateLabel.translatesAutoresizingMaskIntoConstraints = false
		ratingLabel.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate ([
			posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
			posterImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
			posterImageView.widthAnchor.constraint(equalToConstant: contentView.frame.width / 3),
			posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),


			titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
			titleLabel.leftAnchor.constraint(equalTo: posterImageView.rightAnchor, constant: 12),
			titleLabel.rightAnchor.constraint(equalTo:  contentView.rightAnchor, constant: -16),

			overviewLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
			overviewLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			overviewLabel.rightAnchor.constraint(equalTo:  titleLabel.rightAnchor),

			releaseDateLabel.topAnchor.constraint(equalTo: overviewLabel.bottomAnchor, constant: 12),
			releaseDateLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			releaseDateLabel.rightAnchor.constraint(equalTo:  titleLabel.rightAnchor),


			ratingLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor),
			ratingLabel.rightAnchor.constraint(equalTo:  titleLabel.rightAnchor),
			ratingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
		])
	}

	private func configureUI() {
		titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
		titleLabel.numberOfLines = 0

		overviewLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		overviewLabel.numberOfLines = 0

		releaseDateLabel.font = UIFont.systemFont(ofSize: 16, weight: .regular)
		releaseDateLabel.numberOfLines = 1

		posterImageView.contentMode = .scaleAspectFit
	}
}

extension MovieCell: MovieCellInput {
	func configure(viewModel: MovieViewModel) {
		titleLabel.text = viewModel.title
		overviewLabel.text = viewModel.overview
		releaseDateLabel.text = viewModel.releaseDate
		ratingLabel.text = viewModel.rating
		posterImageView.kf.setImage(with: URL(string: viewModel.posterURL))
	}

	func configure(viewModel: SearchResultViewModel) {
		titleLabel.text = viewModel.title
		overviewLabel.text = ""
		releaseDateLabel.text = viewModel.releaseDate
		ratingLabel.text = ""
		posterImageView.kf.setImage(with: URL(string: viewModel.posterURL))
	}
}
