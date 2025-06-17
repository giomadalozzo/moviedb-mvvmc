import UIKit

class DetailViewController: UIViewController {

    private let viewModel: DetailViewModel

    init(movie: Movie, genres: [Genre], poster: UIImage) {
        self.viewModel = DetailViewModel(movie: movie, genres: genres, poster: poster)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let detailView = DetailView()
        detailView.titleLabel.text = self.viewModel.movie.title
        detailView.descriptionLabel.text = self.viewModel.movie.overview
        detailView.scoreLabel.text = "\(self.viewModel.movie.voteAverage)"
        detailView.numberVotesLabel.text = "\(self.viewModel.movie.voteCount)"
        detailView.genresLabel.text = viewModel.genresFromId()
        detailView.posterLabel.image = viewModel.poster
        view = detailView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
