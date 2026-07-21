//
//  RepositoryMocks.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation
import DataStorage
import SwiftData
@testable import BookStore

// MARK: - MockStorageRepository
// Stores PersistentModel instances in memory as AnyObject for identity-based deletion.

final class MockStorageRepository: StorageRepositoryProtocol {
    private var entities: [AnyObject] = []
    var shouldThrow: Bool = false

    func insert<T>(_ entity: T) throws where T: PersistentModel {
        if shouldThrow { throw URLError(.unknown) }
        entities.append(entity as AnyObject)
    }

    func update() throws {
        if shouldThrow { throw URLError(.unknown) }
    }

    func delete<T>(_ entity: T) throws where T: PersistentModel {
        if shouldThrow { throw URLError(.unknown) }
        entities.removeAll { $0 === (entity as AnyObject) }
    }

    func fetch<T>(_ type: T.Type) throws -> [T] where T: PersistentModel {
        if shouldThrow { throw URLError(.unknown) }
        return entities.compactMap { $0 as? T }
    }
}

// MARK: - MockBooksRepository

final class MockBooksRepository: BooksRepositoryProtocol {
    var fetchResult: Result<BooksModel, Error> = .success(.stub())
    var favorites: [BookModel] = []
    var shoppingCart: [BookModel] = []
    var shouldThrow: Bool = false

    private(set) var addFavoriteCallCount = 0
    private(set) var deleteFavoriteCallCount = 0
    private(set) var addCartCallCount = 0
    private(set) var deleteCartCallCount = 0
    private(set) var fetchBooksCallCount = 0

    func fetchBooks(page: Int?, search: String?) async throws -> BooksModel {
        fetchBooksCallCount += 1
        return try fetchResult.get()
    }

    func getFavorites() throws -> [BookModel] {
        if shouldThrow { throw URLError(.unknown) }
        return favorites
    }

    func getShoppingCart() throws -> [BookModel] {
        if shouldThrow { throw URLError(.unknown) }
        return shoppingCart
    }

    func add(favorite model: BookModel) throws {
        if shouldThrow { throw URLError(.unknown) }
        addFavoriteCallCount += 1
        favorites.append(model)
    }

    func delete(favorite model: BookModel) throws {
        if shouldThrow { throw URLError(.unknown) }
        deleteFavoriteCallCount += 1
        favorites.removeAll { $0.id == model.id }
    }

    func add(cart model: BookModel) throws {
        if shouldThrow { throw URLError(.unknown) }
        addCartCallCount += 1
        shoppingCart.append(model)
    }

    func delete(cart model: BookModel) throws {
        if shouldThrow { throw URLError(.unknown) }
        deleteCartCallCount += 1
        shoppingCart.removeAll { $0.id == model.id }
    }

    func isFavorite(model: BookModel) throws -> Bool {
        if shouldThrow { throw URLError(.unknown) }
        return favorites.contains { $0.id == model.id }
    }

    func inShoppingCart(model: BookModel) throws -> Bool {
        if shouldThrow { throw URLError(.unknown) }
        return shoppingCart.contains { $0.id == model.id }
    }
}
