import UIKit

final class CostumSlider: UISlider {

    // Properties
    
    private var trackHeight: CGFloat = 5
    private var thumbRadius: CGFloat = 20

    private lazy var thumbView: UIView = {
        let thumb = UIView()
        thumb.backgroundColor = .link
        thumb.layer.borderWidth = 2
        thumb.layer.borderColor = UIColor.white.cgColor
        return thumb
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        let thumb = thumbImage(radius: thumbRadius)

        setThumbImage(thumb, for: .normal)
    }

    private func thumbImage(radius: CGFloat) -> UIImage {

        thumbView.frame = CGRect(
            x: 0,
            y: radius / 2,
            width: radius,
            height: radius
        )
        thumbView.layer.cornerRadius = radius / 2

        let renderer = UIGraphicsImageRenderer(bounds: thumbView.bounds)
        return renderer.image { rendererContext in
            thumbView.layer.render(in: rendererContext.cgContext)
        }
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        var newRect = super.trackRect(forBounds: bounds)
        newRect.size.height = trackHeight
        return newRect
    }
}
