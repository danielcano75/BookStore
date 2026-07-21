//
//  UseCaseMocks.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation
@testable import BookStore

// MARK: - GetBooksUseCase mock

final class MockGetBooksUseCase: GetBooksUseCaseing {
    var result: Result<BooksModel, Error>
    private(set) var callCount = 0

    init(result: Result<BooksModel, Error> = .success(.stub())) {
        self.result = result
    }

    func execute(page: Int?, search: String?) async throws -> BooksModel {
        callCount += 1
        return try result.get()
    }
}

// MARK: - GetFavoriteBooksUseCase mock

final class MockGetFavoriteBooksUseCase: GetFavoriteBooksUseCaseing {
    var stubbedBooks: [BookModel]
    var shouldThrow: Bool
    private(set) var callCount = 0

    init(stubbedBooks: [BookModel] = [], shouldThrow: Bool = false) {
        self.stubbedBooks = stubbedBooks
        self.shouldThrow = shouldThrow
    }

    func execute() throws -> [BookModel] {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
        return stubbedBooks
    }
}

// MARK: - GetCartBooksUseCase mock

final class MockGetCartBooksUseCase: GetCartBooksUseCaseing {
    var stubbedBooks: [BookModel]
    var shouldThrow: Bool
    private(set) var callCount = 0

    init(stubbedBooks: [BookModel] = [], shouldThrow: Bool = false) {
        self.stubbedBooks = stubbedBooks
        self.shouldThrow = shouldThrow
    }

    func execute() throws -> [BookModel] {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
        return stubbedBooks
    }
}

// MARK: - AddFavoriteUseCase mock

final class MockAddFavoriteUseCase: AddFavoriteUseCaseing {
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
    }
}

// MARK: - DeleteFavoriteUseCase mock

final class MockDeleteFavoriteUseCase: DeleteFavoriteUseCaseing {
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
    }
}

// MARK: - AddCartUseCase mock

final class MockAddCartUseCase: AddCartUseCaseing {
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
    }
}

// MARK: - DeleteCartUseCase mock

final class MockDeleteCartUseCase: DeleteCartUseCaseing {
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
    }
}

// MARK: - ValidateFavoriteUseCase mock

final class MockValidateFavoriteUseCase: ValidateFavoriteUseCaseing {
    var stubbedResult: Bool = false
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws -> Bool {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
        return stubbedResult
    }
}

// MARK: - ValidateCartUseCase mock

final class MockValidateCartUseCase: ValidateCartUseCaseing {
    var stubbedResult: Bool = false
    var shouldThrow: Bool = false
    private(set) var callCount = 0

    func execute(model: BookModel) throws -> Bool {
        callCount += 1
        if shouldThrow { throw URLError(.unknown) }
        return stubbedResult
    }
}
