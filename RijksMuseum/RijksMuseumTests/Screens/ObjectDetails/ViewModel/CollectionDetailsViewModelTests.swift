//
//  CollectionDetailsViewModelTests.swift
//  RijksMuseumTests
//
//  Created by Alessio Roberto on 16/05/22.
//

@testable import RijksMuseum
import XCTest

final class CollectionDetailsViewModelTests: XCTestCase {
    final class TestError: Error {}

    private var subject: CollectionDetailsViewModel!
    private var service: CollectionDetailsRequestingMock!
    private let objectNumber = "SK-C-5"

    override func setUpWithError() throws {
        service = .init()
        subject = .init(service: service, objectNumber: objectNumber)
    }

    override func tearDownWithError() throws {
        subject = nil
        service = nil
    }

    func testInitialState() throws {
        XCTAssert(subject.placeholderTitle == "Somenthing went wrong.\nTry later")
        XCTAssertFalse(subject.isActivityIndicatorAnimating)
        XCTAssertTrue(subject.isPlaceholderHidden)
    }
}
