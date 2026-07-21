//
//  ServiceMocks.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation
import Networking
@testable import BookStore

// MARK: - Stub helpers (shared across all test files)

extension BookModel {
    static func stub(id: Int = 1, price: Double = 9.99) -> BookModel {
        BookModel(
            id: id,
            title: "Book \(id)",
            price: price,
            currency: "USD",
            authors: [Person(name: "Author", birthYear: nil, deathYear: nil)],
            summaries: ["Summary"],
            editors: [],
            translators: [],
            subjects: [],
            bookshelves: [],
            languages: ["en"],
            copyright: false,
            mediaType: "text",
            formats: Formats(
                html: nil, epub: nil, mobi: nil, rdf: nil,
                image: nil, zip: nil, textUTF8: nil, textASCII: nil
            ),
            downloadCount: 0
        )
    }
}

extension BooksModel {
    static func stub(results: [BookModel] = [.stub()]) -> BooksModel {
        BooksModel(count: results.count, next: nil, previous: nil, results: results)
    }
}

// MARK: - MockAPIClient

final class MockAPIClient: APIClientProtocol {
    var stubbedModel: BooksModel
    var shouldThrow: Bool
    private(set) var callCount = 0

    init(stubbedModel: BooksModel = .stub(), shouldThrow: Bool = false) {
        self.stubbedModel = stubbedModel
        self.shouldThrow = shouldThrow
    }

    nonisolated(nonsending) func execute<T>(
        _ endpoint: any Endpoint,
        as type: T.Type
    ) async throws -> NetworkResponse<T> where T: Decodable, T: Sendable {
        callCount += 1
        if shouldThrow { throw URLError(.notConnectedToInternet) }
        guard let model = stubbedModel as? T else {
            throw URLError(.cannotParseResponse)
        }
        return NetworkResponse(value: model, statusCode: 200, headers: [:])
    }
}

// MARK: - MockBooksService

final class MockBooksService: BooksServiceProtocol {
    var result: Result<BooksModel, Error>
    private(set) var callCount = 0

    init(result: Result<BooksModel, Error> = .success(.stub())) {
        self.result = result
    }

    func fetchBooks(page: Int?, search: String?) async throws -> BooksModel {
        callCount += 1
        return try result.get()
    }
}
