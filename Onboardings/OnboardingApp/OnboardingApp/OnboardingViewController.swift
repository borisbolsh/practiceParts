import UIKit

final class OnboardingViewController: UIViewController {

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
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "CellId")

        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.isPagingEnabled = true
    }
}

extension OnboardingViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CellId", for: indexPath)

        var color = UIColor.clear
        if indexPath.item % 2 == 0 {
            color = .red
        } else {
            color = .blue
        }

        cell.backgroundColor = color

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
