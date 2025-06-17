import Foundation

enum Secrets {
    static var tmdbToken: String {
        guard let file = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: file),
              let token = dict["TMDB_API_TOKEN"] as? String else {
            fatalError("API Token not found.")
        }

        return token
    }
}
