import Foundation

/// Communicates with REST API using
/// URL-formatted requests and
/// JSON-formatted responses
public final class UrlRestApiRequester: Requesting {
    private let requester: RestApiRequester

    /// The designated initializer
    /// - Parameter apiUrl: URL of the REST API endpoint
    public init(apiUrl: String) {
        requester = RestApiRequester(
            apiUrl: apiUrl,
            encoder: URLEncoder(),
            decoder: JSONDecoder(),
            method: .get,
            header: ["Content-Type": "application/json"]
        )
    }

    public func make<T>(
        request: T,
        _ completion: @escaping (Result<T.Response, Error>) -> Void
    ) where T: Request {
        requester.make(request: request, completion)
    }
}
