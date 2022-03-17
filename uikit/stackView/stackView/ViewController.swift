import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var backgroundView: UIView!

    @IBOutlet weak var topLeftLabel: UILabel!
    @IBOutlet weak var topRightLabel: UILabel!

    @IBOutlet weak var slider: CostumSlider!

    @IBOutlet weak var bottomLeftLabel: UILabel!
    @IBOutlet weak var bottomRightLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        slider.maximumValue = 100
        slider.minimumValue = 0
        slider.setValue(50, animated: false)
        slider.addTarget(self, action: #selector(sliderTapping(_:)), for: .valueChanged)
    }

    @objc func sliderTapping (_ sender: UISlider){
        print("value is: \(Int(sender.value))")
    }
}

