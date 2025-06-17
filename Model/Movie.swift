import Foundation

struct Movie: Decodable {
    var id: Int
    var title: String
    var voteAverage: Double
    var voteCount: Int
    var releaseDate: String
    var overview: String
    var genreIds: [Int]?
    var posterPath: String
}
