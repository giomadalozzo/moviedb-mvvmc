import Foundation
import UIKit

class MainViewModel {
    var genres: [Genre] = []
    var movies: [Movie] = []

    var onMoviesUpdated: (() -> Void)?
    var onError: ((String) -> Void)?

    private var movieService: MovieService = MovieService()

    func loadData() {
            Task {
                do {
                    await self.getGenres()
                    try await self.getMovies()
                    DispatchQueue.main.async {
                        self.onMoviesUpdated?()
                    }
                } catch {
                    DispatchQueue.main.async {
                        self.onError?(error.localizedDescription)
                    }
                }
            }
        }

    func loadPoster(posterPath: String) async -> UIImage? {
        do {
            let image = try await self.getPoster(posterPath: posterPath)
            return image
        } catch {
            DispatchQueue.main.async {
                self.onError?(error.localizedDescription)
            }
            return nil
        }
    }

    private func getGenres() async {
        do {
            self.genres = try await self.movieService.getGenres()
        } catch {
            DispatchQueue.main.async {
                self.onError?(error.localizedDescription)
            }
        }
    }

    private func getMovies() async throws {
        do {
            self.movies = try await self.movieService.getPopularMovies()
        } catch {
            DispatchQueue.main.async {
                self.onError?(error.localizedDescription)
            }
        }
    }

    private func getPoster(posterPath: String) async throws -> UIImage? {

        guard let urlRequest: URL = URL(string: "https://image.tmdb.org/t/p/w500" + posterPath) else {
            throw URLError(.badURL)
        }

        let (data, _) = try await URLSession.shared.data(from: urlRequest)
        return UIImage(data: data)
    }
}
