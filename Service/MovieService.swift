import Foundation

//protocol MovieServiceProtocol {
//    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
//    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void)
//}
//
//class MovieService: MovieServiceProtocol {
//
//    private var headers: [String: String] {
//            return [
//                "accept": "application/json",
//                "Authorization": "Bearer \(Secrets.tmdbToken)"
//            ]
//        }
//
//    func getGenres(completion: @escaping (Result<[Genre], Error>) -> Void) {
//        let url: String = "https://api.themoviedb.org/3/genre/movie/list"
//
//        guard let urlRequest: URL = URL(string: url) else {
//            completion(.failure(NSError(domain: "URL Error", code: 0)))
//            return
//        }
//
//        var request = URLRequest(url: urlRequest)
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = self.headers
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No data", code: 0)))
//                return
//            }
//            
//            do {
//                let response: GenreResponse = try JSONDecoder().decode(GenreResponse.self, from: data)
//                completion(.success(response.genres))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//    
//    func getPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
//        let url: String = "https://api.themoviedb.org/3/movie/popular"
//
//        guard let urlRequest: URL = URL(string: url) else {
//            completion(.failure(NSError(domain: "URL Error", code: 0)))
//            return
//        }
//
//        var request = URLRequest(url: urlRequest)
//
//        request.httpMethod = "GET"
//        request.timeoutInterval = 10
//        request.allHTTPHeaderFields = self.headers
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data else {
//                completion(.failure(NSError(domain: "No data", code: 0)))
//                return
//            }
//
//            do {
//                let decoder = JSONDecoder()
//                decoder.keyDecodingStrategy = .convertFromSnakeCase
//
//                let movies: MovieResponse = try decoder.decode(MovieResponse.self, from: data)
//
//                completion(.success(movies.results))
//            } catch {
//                completion(.failure(error))
//            }
//        }.resume()
//    }
//}


protocol MovieServiceProtocol {
    func getGenres() async throws -> [Genre]
    func getPopularMovies() async throws -> [Movie]
}

class MovieService: MovieServiceProtocol {

    private var headers: [String: String] {
        return [
            "accept": "application/json",
            "Authorization": "Bearer \(Secrets.tmdbToken)"
        ]
    }

    private var decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        return decoder
    }()

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }


    func getGenres() async throws -> [Genre] {
        let url: String = "https://api.themoviedb.org/3/genre/movie/list"
        guard let urlRequest: URL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: urlRequest)

        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = self.headers

        let (data, _) = try await self.session.data(for: request)

        let decoded = try self.decoder.decode(GenreResponse.self, from: data)

        return decoded.genres
    }
    
    func getPopularMovies() async throws -> [Movie] {
        let url: String = "https://api.themoviedb.org/3/movie/popular"

        guard let urlRequest: URL = URL(string: url) else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: urlRequest)

        request.httpMethod = "GET"
        request.timeoutInterval = 10
        request.allHTTPHeaderFields = self.headers

        let (data, _) = try await self.session.data(for: request)

        let decoded = try self.decoder.decode(MovieResponse.self, from: data)

        return decoded.results
    }
}
