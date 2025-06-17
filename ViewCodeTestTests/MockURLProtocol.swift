import Foundation

class MockURLProtocol: URLProtocol {

    static var stubResponseData: Data?
    static var stubError: Error?

    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }

    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }

    override func startLoading() {
        if let error = MockURLProtocol.stubError {
            self.client?.urlProtocol(self, didFailWithError: error)
        } else {
            let response = HTTPURLResponse(
                url: request.url!,
                statusCode: 200,
                httpVersion: nil,
                headerFields: nil
            )!

            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = MockURLProtocol.stubResponseData {
                self.client?.urlProtocol(self, didLoad: data)
            }

            self.client?.urlProtocolDidFinishLoading(self)
        }
    }

    override func stopLoading() {}
}
