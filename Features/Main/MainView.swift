import UIKit
import SwiftUI

class MainView: UIView {

    let tableView: UITableView = {
        let table = UITableView()

        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(MainTableCell.self, forCellReuseIdentifier: MainTableCell.identifier)

        return table
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupView() {
        addSubview(tableView)
        self.setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
                    tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
                    tableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
                    tableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
                    tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
                ])
    }
}

#if DEBUG
struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        MainView().toPreview()
    }
}
#endif

