import UIKit

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    func start() {
        let viewController = MainViewController()
        viewController.delegate = self

        viewController.title = "MovieDB App"
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = .black
        navigationController.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.lightGray]

        navigationController.pushViewController(viewController, animated: false)
    }
}

extension AppCoordinator: MainViewControllerDelegate {
    func didSelectRow(movie: Movie, genres: [Genre], poster: UIImage) {
        let detailVC = DetailViewController(movie: movie, genres: genres, poster: poster)
        navigationController.pushViewController(detailVC, animated: true)
    }
}
