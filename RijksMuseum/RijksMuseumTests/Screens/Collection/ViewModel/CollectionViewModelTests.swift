//
//  CollectionViewModelTests.swift
//  RijksMuseumTests
//
//  Created by Alessio Roberto on 12/05/22.
//

@testable import RijksMuseum
import XCTest

final class CollectionViewModelTests: XCTestCase {
    final class TestError: Error {}

    private var subject: CollectionViewModel!
    private var service: CollectionRequestingMock!
    private var router: CollectionRoutingMock!

    override func setUpWithError() throws {
        service = .init()
        router = .init()
        subject = .init(service: service, router: router)
    }

    override func tearDownWithError() throws {
        subject = nil
        service = nil
        router = nil
    }

    func testInitialState() throws {
        XCTAssert(subject.columnsCount == 2)
        XCTAssert(subject.placeholderTitle == "No results")
        XCTAssertFalse(subject.isActivityIndicatorAnimating)
        XCTAssertFalse(subject.isPlaceholderHidden)
    }
}
