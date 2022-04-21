import UIKit

final class TableViewDataSource: NSObject {

    weak var table: UITableView?
    var navbarheigh: CGFloat?

    private struct Constants {
        static let headerHeight: CGFloat = 80
    }
    private var previousScrollOffset: CGFloat = 0.0
}

extension TableViewDataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        100
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "Row No.\(indexPath.row)"
        return cell
    }
}

extension TableViewDataSource: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {

        guard let navbarheigh = navbarheigh else {
            return
        }

        let y = scrollView.contentOffset.y + navbarheigh

        if y > 1 && y < 80 {
            UIView.animate(withDuration: 0.8) {
                self.table?.tableHeaderView?.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.8) {
                self.table?.tableHeaderView?.alpha = 1.0
            }
        }
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {}
}
