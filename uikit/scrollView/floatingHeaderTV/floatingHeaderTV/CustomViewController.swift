import UIKit

final class CustomViewController: UIViewController {

    private var dataSourse: TableViewDataSource?
    @IBOutlet weak var tableView: UITableView!

    init(dataSourse: TableViewDataSource){
        self.dataSourse = dataSourse
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSubviews()
    }

    func setupSubviews(){
        self.title = "Header"

        dataSourse?.table = tableView
        dataSourse?.navbarheigh = getNavbarHeight()
        tableView.dataSource = dataSourse
        tableView.delegate = dataSourse

        let headerView = UIView(
            frame: CGRect(
                x: 0, y: 0, width: 0, height: 80
            )
        )

        headerView.backgroundColor = .red
        tableView.tableHeaderView = headerView

    }
}

extension CustomViewController {
    func getNavbarHeight() -> CGFloat {
        var result = self.navigationController?.navigationBar.frame.height ?? 0.0
        if #available(iOS 13.0, *) {
            result += UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0
        } else {
            result += UIApplication.shared.statusBarFrame.height
        }
        return result
    }
}
