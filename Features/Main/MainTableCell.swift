import UIKit
import SwiftUI

class MainTableCell: UITableViewCell {
    static let identifier: String = "MainTableCell"

    let titleLabel: UILabel = {
        let title = UILabel()
        
        title.textColor = .black
        title.text = "Text placeholder"
        title.translatesAutoresizingMaskIntoConstraints = false

        return title
    }()

    let posterLabel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "film")

        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.brown.cgColor
        image.layer.cornerRadius = 2

        return image
    }()

    let scoreLabel: UILabel = {
        let score = UILabel()

        score.textColor = .black
        score.text = "Nota"
        score.translatesAutoresizingMaskIntoConstraints = false

        return score
    }()

    let releaseLabel: UILabel = {
        let release = UILabel()

        release.textColor = .black
        release.text = "16/11/2022"
        release.translatesAutoresizingMaskIntoConstraints = false

        return release
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupLayout()
    }

    private func setupLayout() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(posterLabel)
        contentView.addSubview(scoreLabel)
        contentView.addSubview(releaseLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterLabel.widthAnchor.constraint(equalToConstant: 70),
            posterLabel.heightAnchor.constraint(equalToConstant: 90),
            posterLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            posterLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8)
        ])

        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: posterLabel.trailingAnchor, constant: 8),
            titleLabel.topAnchor.constraint(equalTo: posterLabel.topAnchor, constant: 4)
        ])

        NSLayoutConstraint.activate([
            scoreLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12)
        ])

        NSLayoutConstraint.activate([
            releaseLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            releaseLabel.topAnchor.constraint(equalTo: scoreLabel.bottomAnchor, constant: 4),
            releaseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
struct MainTableCell_Preview: PreviewProvider {
    static var previews: some View {
        MainTableCell().toPreview()
    }
}
#endif
