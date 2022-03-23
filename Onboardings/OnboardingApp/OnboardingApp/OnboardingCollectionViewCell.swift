import UIKit

final class OnboardingCollectionViewCell: UICollectionViewCell {


    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    func configure(with slide: SlideModel) {
        titleLabel.text = slide.title
        actionButton.backgroundColor = slide.buttonColor
        actionButton.setTitle(slide.buttonTitle, for: .normal)
    }

    @IBAction func actionButtonTapped() {
    }
}
