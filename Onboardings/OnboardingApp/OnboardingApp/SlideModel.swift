import Foundation
import UIKit

struct SlideModel{
    let title: String
    let animationName: String
    let buttonColor: UIColor
    let buttonTitle: String

    static let collection: [SlideModel] = [
        .init(title: "Get your favorite food delivered to you under 30 minutes anytime", animationName: "", buttonColor: .systemYellow, buttonTitle: "Next"),
        .init(title: "We serve only from choiced restaurants in your area", animationName: "", buttonColor: .systemGreen, buttonTitle: "Order Now")
    ]
}
