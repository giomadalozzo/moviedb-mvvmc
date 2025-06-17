import UIKit
import SwiftUI

class DetailView: UIView {
    var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        label.text = "Title placeholder"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        return label
    }()

    let descriptionLabel: UILabel = {
        let description = UILabel()

        description.textColor = .gray
        description.text = "Description placeholder"
        description.translatesAutoresizingMaskIntoConstraints = false
        description.numberOfLines = 0
        description.lineBreakMode = .byWordWrapping

        return description
    }()

    let scoreLabel: UILabel = {
        let score = UILabel()

        score.textColor = .black
        score.text = "4.7"
        score.translatesAutoresizingMaskIntoConstraints = false

        return score
    }()

    let numberVotesLabel: UILabel = {
        let numberVotes = UILabel()

        numberVotes.textColor = .black
        numberVotes.text = "3000 votes"
        numberVotes.translatesAutoresizingMaskIntoConstraints = false

        return numberVotes
    }()

    let genresLabel: UILabel = {
        let genres = UILabel()

        genres.textColor = .lightGray
        genres.text = "Action, Adventure, Comedy"
        genres.translatesAutoresizingMaskIntoConstraints = false

        return genres
    }()

    let posterLabel: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.image = UIImage(systemName: "film")

        image.layer.borderWidth = 1
        image.layer.borderColor = UIColor.brown.cgColor
        image.layer.cornerRadius = 2

        return image
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setupView()
    }

    private func setupView() {
        addSubview(titleLabel)
        addSubview(posterLabel)
        addSubview(descriptionLabel)
        addSubview(scoreLabel)
        addSubview(numberVotesLabel)
        addSubview(genresLabel)
        setupConstraints()
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate([
            posterLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 8),
            posterLabel.widthAnchor.constraint(equalToConstant: 200),
            posterLabel.heightAnchor.constraint(equalToConstant: 300),
            posterLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: posterLabel.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])

        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            descriptionLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            descriptionLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 12),
            descriptionLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -12)
        ])

        NSLayoutConstraint.activate([
            scoreLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: descriptionLabel.leadingAnchor, constant: 45)
        ])

        NSLayoutConstraint.activate([
            numberVotesLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 8),
            numberVotesLabel.trailingAnchor.constraint(equalTo: descriptionLabel.trailingAnchor, constant: -45)
        ])

        NSLayoutConstraint.activate([
            genresLabel.topAnchor.constraint(equalTo: numberVotesLabel.bottomAnchor, constant: 8),
            genresLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])


    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if DEBUG
struct Detail_Preview: PreviewProvider {
    static var previews: some View {
        DetailView().toPreview()
    }
}
#endif
