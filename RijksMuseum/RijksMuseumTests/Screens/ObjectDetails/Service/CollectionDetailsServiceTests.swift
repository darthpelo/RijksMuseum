//
//  CollectionDetailsServiceTests.swift
//  RijksMuseumTests
//
//  Created by Alessio Roberto on 12/05/22.
//

@testable import RijksMuseum
import XCTest

final class CollectionDetailsServiceTests: XCTestCase {
    private final class TestError: LocalizedError {}

    private var subject: CollectionDetailsService!
    private var requester: RequestingMock<CollectionDetailsRequest>!

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

    func testDetailsRequestcomposing() throws {
        // given
        let objectNumber = "SK-C-5"

        // when request starts
        subject.getImage(ofObjectNumber: objectNumber) { _ in }
        // then it should be composed correctly
        let request = requester.makeRequestReceivedArguments?.request
        XCTAssertEqual(request?.query, "\(objectNumber)?key=0fiuZFh4")
    }

    func testSuccessfulDetailsLoad() throws {
        // given
        let objectNumber = "SK-C-5"
        let response = CollectionDetailsRequest.Response(artObject:
            .init(objectNumber: objectNumber,
                  principalOrFirstMaker: "principalOrFirstMaker",
                  title: "title",
                  description: "description",
                  webImage: .init(url: "url"))
        )

        requester.makeRequestClosure = { _, completion in
            completion(.success(response))
        }

        var receivedModel: (title: String, url: String)!

        // when request finishes
        subject.getImage(ofObjectNumber: objectNumber) { result in
            if case let .success(model) = result {
                receivedModel = model
            }
        }

        // then it should be correct
        XCTAssertEqual(receivedModel.title, "title")
        XCTAssertEqual(receivedModel.url, "url")
    }

    func testFailedLoad() throws {
        // given
        let error = TestError()

        requester.makeRequestClosure = { _, completion in
            completion(.failure(error))
        }

        var receivedError: TestError!

        // when request fails
        subject.getImage(ofObjectNumber: "") { result in
            if case let .failure(error) = result {
                receivedError = error as? TestError
            }
        }

        // then it should notify the receiver
        XCTAssert(receivedError === error)
    }
}
