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

    private var subject: CollectionService!
    private var requester: RequestingMock<CollectionRequest>!

    override func setUpWithError() throws {
        requester = .init()
        subject = .init(requester: { _ in
            requester
        })
    }

    override func tearDownWithError() throws {
        subject = nil
        requester = nil
    }

    func testRequestComposing() throws {
        // given
        let maxResults = Int.random(in: 0 ..< 100)
        let page = Int.random(in: 0 ..< 100)

        // when request starts
        subject.getImages(ofMaxResults: maxResults, forPage: page) { _ in }

        // then it should be composed correctly
        let request = requester.makeRequestReceivedArguments?.request
        XCTAssertEqual(request?.query, "?key=0fiuZFh4&imgonly=true&type=painting&p=\(page)&ps=\(maxResults)")
    }

    func testSuccessfulLoad() throws {
        // given
        let response = CollectionRequest.Response(artObjects: [
            .init(objectNumber: "objectNumber",
                  title: "title",
                  webImage: .init(url: "url")),
        ])
        requester.makeRequestClosure = { _, completion in
            completion(.success(response))
        }

        var receivedModel: [(title: String, url: String)]!

        // when request finishes
        subject.getImages(ofMaxResults: 0, forPage: 0) { result in
            if case let .success(model) = result {
                receivedModel = model
            }
        }

        // then it should be correct
        XCTAssertEqual(receivedModel.first?.title, "title")
        XCTAssertEqual(receivedModel.first?.url, "url")
    }

    func testFailedLoad() throws {
        // given
        let error = TestError()

        requester.makeRequestClosure = { _, completion in
            completion(.failure(error))
        }

        var receivedError: TestError!

        // when request fails
        subject.getImages(ofMaxResults: 0, forPage: 0) { result in
            if case let .failure(error) = result {
                receivedError = error as? TestError
            }
        }

        // then it should notify the receiver
        XCTAssert(receivedError === error)
    }
}
