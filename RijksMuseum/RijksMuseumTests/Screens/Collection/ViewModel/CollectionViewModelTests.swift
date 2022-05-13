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
        XCTAssert(subject.placeholderTitle == "Somenthing went wrong.\nTry later")
        XCTAssertFalse(subject.isActivityIndicatorAnimating)
        XCTAssertTrue(subject.isPlaceholderHidden)
    }

    func testEmptyQueryRefresh() throws {
        // given
        var deactivated: Bool!
        subject.onPullToRefreshDeactivation = {
            deactivated = true
        }

        // when user tries to refresh a screen with no result
        subject.onPullToRefresh()

        // it should immediately deactivate the refresh control
        XCTAssertTrue(deactivated)
    }

    func testNavigation() {
        // given
        var deactivated: Bool!
        subject.onPullToRefreshDeactivation = {
            deactivated = true
        }

        // when the view is loaded
        subject.onViewLoad()

        // it should
        // 1. Show activity indicator
        XCTAssertTrue(subject.isActivityIndicatorAnimating)
        // 2. Deactivate the refresh control
        XCTAssertTrue(deactivated)
    }

    func testReload() {
        // given
        let query = "query"
        router.showCollectionClosure = { completion in
            completion(query)
        }

        let collection: [ArtObjectData] = [(title: "abc", url: "", objectNumber: ""),
                                           (title: "abc", url: "", objectNumber: ""),
                                           (title: "abc", url: "", objectNumber: "")]
        service.getImagesOfMaxResultsForPageClosure = { _, _, completion in
            completion(.success(collection))
        }

        let expectation = expectation(description: "view should reload")
        var then: (() -> Void)?
        subject.onReload = {
            expectation.fulfill()
            then?()
        }

        // when the view is loaded
        subject.onViewLoad()

        wait(for: [expectation], timeout: 5.0)

        // then it should request the first page
        then = { [weak subject] in
            XCTAssert(subject?.collection.count == collection.count)
            XCTAssert(subject?.isActivityIndicatorAnimating == false)
        }
    }

    func testPageLoad() {
        // given
        let query = "query"
        router.showCollectionClosure = { completion in
            completion(query)
        }

        let collection: [ArtObjectData] = [(title: "abc", url: "", objectNumber: ""),
                                           (title: "abc", url: "", objectNumber: ""),
                                           (title: "abc", url: "", objectNumber: "")]
        service.getImagesOfMaxResultsForPageClosure = { _, _, completion in
            completion(.success(collection))
        }

        subject.onReload = { [weak subject] in
            subject?.onBottomDragging()
        }

        let expectation = expectation(description: "view should load second page")
        var insertedSections: IndexSet!
        var then: (() -> Void)?
        subject.onSectionsInsertion = {
            insertedSections = $0
            expectation.fulfill()
            then?()
        }

        // when the view is loaded
        subject.onViewLoad()

        wait(for: [expectation], timeout: 5.0)

        // then it should request the second page
        then = { [weak subject] in
            XCTAssert(subject?.collection.count == collection.count * 2)
            XCTAssert(insertedSections == .init(integersIn: collection.count ..< collection.count * 2))
            XCTAssert(subject?.isActivityIndicatorAnimating == false)
        }
    }

    func testPlaceholderVisibility() {
        // given
        let query = "query"
        router.showCollectionClosure = { completion in
            completion(query)
        }

        let expectation = expectation(description: "service should fail")
        var then: (() -> Void)?
        service.getImagesOfMaxResultsForPageClosure = { _, _, completion in
            completion(.failure(TestError()))
            expectation.fulfill()
            then?()
        }

        // when the view is loaded
        subject.onViewLoad()

        wait(for: [expectation], timeout: 5.0)

        // then it show the placeholder
        then = { [weak subject] in
            XCTAssert(subject?.isPlaceholderHidden == false)
        }
    }
}
