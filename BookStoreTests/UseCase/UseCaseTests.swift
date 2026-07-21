//
//  UseCaseTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.useCase))
struct UseCaseTests {

    // MARK: - GetBooksUseCase

    @Test func getBooks_execute_callsRepository() async throws {
        let expected = BooksModel.stub(results: [.stub(id: 10)])
        let repo = MockBooksRepository()
        repo.fetchResult = .success(expected)
        let useCase = GetBooksUseCase(repository: repo)

        let result = try await useCase.execute(page: 1, search: nil)

        #expect(result.results.first?.id == 10)
        #expect(repo.fetchBooksCallCount == 1)
    }

    // MARK: - GetFavoriteBooksUseCase

    @Test func getFavoriteBooks_execute_returnsFavoritesFromRepository() throws {
        let repo = MockBooksRepository()
        repo.favorites = [.stub(id: 1), .stub(id: 2)]
        let useCase = GetFavoriteBooksUseCase(repository: repo)

        let result = try useCase.execute()

        #expect(result.count == 2)
        #expect(result.first?.id == 1)
    }

    // MARK: - GetCartBooksUseCase

    @Test func getCartBooks_execute_returnsCartFromRepository() throws {
        let repo = MockBooksRepository()
        repo.shoppingCart = [.stub(id: 3)]
        let useCase = GetCartBooksUseCase(repository: repo)

        let result = try useCase.execute()

        #expect(result.count == 1)
        #expect(result.first?.id == 3)
    }

    // MARK: - AddFavoriteUseCase

    @Test func addFavorite_execute_callsRepositoryAdd() throws {
        let repo = MockBooksRepository()
        let useCase = AddFavoriteUseCase(repository: repo)

        try useCase.execute(model: .stub())

        #expect(repo.addFavoriteCallCount == 1)
    }

    // MARK: - DeleteFavoriteUseCase

    @Test func deleteFavorite_execute_callsRepositoryDelete() throws {
        let repo = MockBooksRepository()
        let useCase = DeleteFavoriteUseCase(repository: repo)

        try useCase.execute(model: .stub())

        #expect(repo.deleteFavoriteCallCount == 1)
    }

    // MARK: - AddCartUseCase

    @Test func addCart_execute_callsRepositoryAdd() throws {
        let repo = MockBooksRepository()
        let useCase = AddCartUseCase(repository: repo)

        try useCase.execute(model: .stub())

        #expect(repo.addCartCallCount == 1)
    }

    // MARK: - DeleteCartUseCase

    @Test func deleteCart_execute_callsRepositoryDelete() throws {
        let repo = MockBooksRepository()
        let useCase = DeleteCartUseCase(repository: repo)

        try useCase.execute(model: .stub())

        #expect(repo.deleteCartCallCount == 1)
    }

    // MARK: - ValidateFavoriteUseCase

    @Test func validateFavorite_execute_returnsRepositoryResult() throws {
        let repo = MockBooksRepository()
        repo.favorites = [.stub(id: 1)]
        let useCase = ValidateFavoriteUseCase(repository: repo)

        let result = try useCase.execute(model: .stub(id: 1))

        #expect(result == true)
    }

    // MARK: - ValidateCartUseCase

    @Test func validateCart_execute_returnsRepositoryResult() throws {
        let repo = MockBooksRepository()
        repo.shoppingCart = [.stub(id: 2)]
        let useCase = ValidateCartUseCase(repository: repo)

        let result = try useCase.execute(model: .stub(id: 2))

        #expect(result == true)
    }
}
