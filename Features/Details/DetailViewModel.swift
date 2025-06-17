import Foundation
import UIKit

class DetailViewModel {
    var movie: Movie
    var genres: [Genre]
    var poster: UIImage

    init(movie: Movie, genres: [Genre], poster: UIImage) {
        self.movie = movie
        self.genres = genres
        self.poster = poster
    }

    func genresFromId() -> String{
        let genreNames = self.movie.genreIds?.compactMap { id in
            self.genres.first(where: { $0.id == id })?.name
        }

        return genreNames?.joined(separator: ", ") ?? ""
    }
}
