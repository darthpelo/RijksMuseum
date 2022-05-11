import Foundation

/// Operation that performs synchronous task
public final class SyncOperation<T>: Operation {
    override public var isExecuting: Bool { isRunning }
    override public var isFinished: Bool { isDone }
    override public var isAsynchronous: Bool { true }

    private var isRunning = false
    private var isDone = false

    private let task: () -> (T)
    private let completion: (T) -> Void

    /// Designated initializer
    /// - Parameters:
    ///   - task: Synchronous task
    ///   - completion: Task completion handler
    public init(
        task: @escaping () -> (T),
        completion: @escaping (T) -> Void
    ) {
        self.task = task
        self.completion = completion
    }

    override public func start() {
        guard !isCancelled else { finish(); return }

        willChangeValue(for: \.isExecuting)
        isRunning = true
        didChangeValue(for: \.isExecuting)

        perform()
    }

    override public func cancel() {
        super.cancel()
        finish()
    }

    private func perform() {
        let result = task()

        if !isCancelled {
            completion(result)
        }

        finish()
    }

    private func finish() {
        willChangeValue(for: \.isExecuting)
        isRunning = false
        didChangeValue(for: \.isExecuting)

        willChangeValue(for: \.isFinished)
        isDone = true
        didChangeValue(for: \.isFinished)
    }
}
