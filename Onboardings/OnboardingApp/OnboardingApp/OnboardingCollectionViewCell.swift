import UIKit
import Lottie

final class OnboardingCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var animationView: AnimationView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var actionButton: UIButton!

    var actionButtonDidTap: (() -> Void)?

    func configure(with slide: SlideModel) {
        titleLabel.text = slide.title
        actionButton.backgroundColor = slide.buttonColor
        actionButton.setTitle(slide.buttonTitle, for: .normal)

        let animation = Animation.named(slide.animationName)

        animationView.animation = animation
        animationView.loopMode = .loop

        if !animationView.isAnimationPlaying{
            animationView.play()
        }
    }

    @IBAction func actionButtonTapped() {
        actionButtonDidTap?()
    }
}
