import XCTest
@testable import ViewCodeTest

final class MovieServiceTests: XCTestCase {

    var sut: MovieService!

    override func setUp() {
        super.setUp()

        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        let session = URLSession(configuration: config)

        sut = MovieService(session: session)
    }

    override func tearDown() {
        sut = nil
        MockURLProtocol.stubResponseData = nil
        MockURLProtocol.stubError = nil
        super.tearDown()
    }

    func testGetGenres_Success() async throws {
        // Given
        let json = """
        {
            "genres": [
                { "id": 28, "name": "Action" },
                { "id": 35, "name": "Comedy" }
            ]
        }
        """

        MockURLProtocol.stubResponseData = json.data(using: .utf8)

        // When
        let genres = try await sut.getGenres()

        // Then
        XCTAssertEqual(genres.count, 2)
        XCTAssertEqual(genres.first?.name, "Action")
    }

    func testGetPopularMovies_Success() async throws {
        // Given
        let json = """
        {
          "page": 1,
          "results": [
            {
              "adult": false,
              "backdrop_path": "/uIpJPDNFoeX0TVml9smPrs9KUVx.jpg",
              "genre_ids": [
                27,
                9648
              ],
              "id": 574475,
              "original_language": "en",
              "original_title": "Final Destination Bloodlines",
              "overview": "Plagued by a violent recurring nightmare, college student Stefanie heads home to track down the one person who might be able to break the cycle and save her family from the grisly demise that inevitably awaits them all.",
              "popularity": 1075.9213,
              "poster_path": "/6WxhEvFsauuACfv8HyoVX6mZKFj.jpg",
              "release_date": "2025-05-14",
              "title": "Final Destination Bloodlines",
              "video": false,
              "vote_average": 7.1,
              "vote_count": 745
            }]
        }
        """
        MockURLProtocol.stubResponseData = json.data(using: .utf8)

        // When
        let movies = try await sut.getPopularMovies()

        // Then
        XCTAssertEqual(movies.count, 1)
        XCTAssertEqual(movies.first?.title, "Final Destination Bloodlines")
    }

    func testGetGenres_Failure() async {
        // Given
        MockURLProtocol.stubError = NSError(domain: "Test", code: 1)
        
        // When
        do {
            _ = try await sut.getGenres()

        // Then
            XCTFail("Esperado erro, mas sucesso foi retornado")
        } catch {
            XCTAssertNotNil(error)
        }
    }

    func testGetPopularMovies_Failure() async {
        // Given
        MockURLProtocol.stubError = NSError(domain: "Test", code: 1)
        
        // When
        do {
            let movies = try await sut.getPopularMovies()

        // Then
            XCTFail("Esperado erro, mas sucesso foi retornado")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
