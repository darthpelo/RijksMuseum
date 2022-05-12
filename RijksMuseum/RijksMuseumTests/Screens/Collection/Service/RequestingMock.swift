/// - Note: `Sourcery` is unable to produce compilable
/// mock for `Requesting` so we have to do it manually
final class RequestingMock<T: Request>: Requesting {
    var makeRequestCallsCount = 0
    var makeRequestCalled: Bool {
        makeRequestCallsCount > 0
    }

    var makeRequestReceivedArguments: (request: T, completion: (Result<T.Response, Error>) -> Void)?
    var makeRequestReceivedInvocations: [(request: T, completion: (Result<T.Response, Error>) -> Void)] = []
    var makeRequestClosure: ((T, @escaping (Result<T.Response, Error>) -> Void) -> Void)?

    func make<V>(request: V, _ completion: @escaping (Result<V.Response, Error>) -> Void) where V: Request {
        guard
            let request = request as? T,
            let completion = completion as? (Result<T.Response, Error>) -> Void
        else {
            return
        }

        makeRequestCallsCount += 1
        makeRequestReceivedArguments = (request: request, completion: completion)
        makeRequestReceivedInvocations.append((request: request, completion: completion))
        makeRequestClosure?(request, completion)
    }
}
