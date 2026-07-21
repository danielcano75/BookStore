//
//  BooksRepositoryTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.repository))
struct BooksRepositoryTests {

    // MARK: - fetchBooks

    @Test func fetchBooks_delegatesToService() async throws {
        let expected = BooksModel.stub(results: [.stub(id: 5)])
        let mockService = MockBooksService(result: .success(expected))
        let mockStorage = MockStorageRepository()
        let repo = BooksRepository(storage: mockStorage, service: mockService)

        let result = try await repo.fetchBooks(page: 1, search: nil)

        #expect(result.results.first?.id == 5)
        #expect(mockService.callCount == 1)
    }

    // MARK: - Favorites

    @Test func addFavorite_storesFavorite() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 1)

        try repo.add(favorite: book)
        let favorites = try repo.getFavorites()

        #expect(favorites.count == 1)
        #expect(favorites.first?.id == 1)
    }

    @Test func deleteFavorite_removesFavorite() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 1)

        try repo.add(favorite: book)
        try repo.delete(favorite: book)
        let favorites = try repo.getFavorites()

        #expect(favorites.isEmpty)
    }

    @Test func isFavorite_returnsFalse_beforeAdding() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 1)

        let result = try repo.isFavorite(model: book)

        #expect(result == false)
    }

    @Test func isFavorite_returnsTrue_afterAdding() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 1)

        try repo.add(favorite: book)
        let result = try repo.isFavorite(model: book)

        #expect(result == true)
    }

    // MARK: - Shopping Cart

    @Test func addCart_storesInCart() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 2)

        try repo.add(cart: book)
        let cart = try repo.getShoppingCart()

        #expect(cart.count == 1)
        #expect(cart.first?.id == 2)
    }

    @Test func deleteCart_removesFromCart() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 2)

        try repo.add(cart: book)
        try repo.delete(cart: book)
        let cart = try repo.getShoppingCart()

        #expect(cart.isEmpty)
    }

    @Test func inShoppingCart_returnsFalse_beforeAdding() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 2)

        let result = try repo.inShoppingCart(model: book)

        #expect(result == false)
    }

    @Test func inShoppingCart_returnsTrue_afterAdding() throws {
        let mockStorage = MockStorageRepository()
        let mockService = MockBooksService()
        let repo = BooksRepository(storage: mockStorage, service: mockService)
        let book = BookModel.stub(id: 2)

        try repo.add(cart: book)
        let result = try repo.inShoppingCart(model: book)

        #expect(result == true)
    }
}
