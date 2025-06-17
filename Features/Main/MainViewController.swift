import UIKit

class MainViewController: UIViewController {

    weak var delegate: MainViewControllerDelegate?

    private let customView = MainView()
    private let viewModel = MainViewModel()

    override func loadView() {
        view = customView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        customView.tableView.delegate = self
        customView.tableView.dataSource = self
        customView.backgroundColor = .systemBackground

        viewModel.onMoviesUpdated = { [weak self] in
            self?.customView.tableView.reloadData()
        }

        viewModel.onError = { [weak self] message in
            let alert = UIAlertController(title: "Erro", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self?.present(alert, animated: true)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadData()
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableCell.identifier, for: indexPath) as? MainTableCell else {
            return UITableViewCell()
        }

        cell.titleLabel.text = viewModel.movies[indexPath.row].title
        cell.releaseLabel.text = viewModel.movies[indexPath.row].releaseDate
        cell.scoreLabel.text = "\(viewModel.movies[indexPath.row].voteAverage)"

        let posterPath = viewModel.movies[indexPath.row].posterPath
        Task {
            let image = await viewModel.loadPoster(posterPath: posterPath)
            cell.posterLabel.image = image
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? MainTableCell {
            guard let image = cell.posterLabel.image else { return }
            delegate?.didSelectRow(movie: viewModel.movies[indexPath.row], genres: viewModel.genres, poster: image)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

protocol MainViewControllerDelegate: AnyObject {
    func didSelectRow(movie: Movie, genres: [Genre], poster: UIImage)
}

