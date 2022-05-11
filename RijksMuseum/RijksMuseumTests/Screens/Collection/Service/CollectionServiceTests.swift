//
//  CollectionServiceTests.swift
//  RijksMuseumTests
//
//  Created by Alessio Roberto on 11/05/22.
//

@testable import RijksMuseum
import XCTest

final class CollectionServiceTests: XCTestCase {
    private final class TestError: LocalizedError {}

    private var requester: RequestingMock<CollectionRequest>!

    override func setUpWithError() throws {
        requester = .init()
    }

    override func tearDownWithError() throws {
        requester = nil
    }
}
