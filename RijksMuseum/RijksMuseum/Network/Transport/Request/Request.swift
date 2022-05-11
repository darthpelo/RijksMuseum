import Foundation

/// Request to the remote system
public protocol Request {
    /// Type of the response of the request
    associatedtype Response: Decodable

    /// Query of the request, e.g. pagination, involvedMaker etc
    var query: String { get }
}
