import UIKit

final class OnboardingViewController: UIViewController {

    private let slides: [SlideModel] = SlideModel.collection
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
    }

    private func setUpCollectionView(){
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical

        collectionView.collectionViewLayout = layout

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        slides.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "CellId",
            for: indexPath
        ) as? OnboardingCollectionViewCell else {
            return UICollectionViewCell()
        }
        let slide = slides[indexPath.item]
        cell.configure(with: slide)
        return cell
    }


}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemWidth = collectionView.bounds.width
        let itemHeight = collectionView.bounds.height

        return CGSize(width: itemWidth, height: itemHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
