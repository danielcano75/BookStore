//
//  BooksRepository.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation
import DataStorage
import SwiftData

enum BooksRepositoryErrors: Error {
    case missingSetupStorage
    case missingSetupService
}

final class BooksRepository: BooksRepositoryProtocol {
    static let shared = BooksRepository()

    private var storage: StorageRepositoryProtocol?
    private var service: BooksServiceProtocol?

    func setup(schema: Schema, service: BooksServiceProtocol) throws {
        let configuration = StorageConfiguration(schema: schema)
        self.storage = try StorageFactory.create(with: configuration)
        self.service = service
    }

    private func getStorage() throws -> StorageRepositoryProtocol {
        guard let storage else { throw BooksRepositoryErrors.missingSetupStorage }
        return storage
    }

    private func getService() throws -> BooksServiceProtocol {
        guard let service else { throw BooksRepositoryErrors.missingSetupService }
        return service
    }

    func fetchBooks(page: Int?, search: String?) async throws -> BooksModel {
        return try await getService().fetchBooks(page: page, search: search)
    }

    func getFavorites() throws -> [BookModel] {
        let storage = try getStorage()
        return try storage.fetch(BookEntity.self)
            .filter { $0.isFavorite }
            .map { BookEntityToModelConversor.toModel(entity: $0) }
    }

    func getShoppingCart() throws -> [BookModel] {
        let storage = try getStorage()
        return try storage.fetch(BookEntity.self)
            .filter { $0.inShoppingCart }
            .map { BookEntityToModelConversor.toModel(entity: $0) }
    }

    func add(favorite model: BookModel) throws {
        let storage = try getStorage()
        if let existing = try storage.fetch(BookEntity.self).first(where: { $0.id == model.id }) {
            existing.isFavorite = true
            try storage.update()
            return
        }
        let entity = BookModelToEntityConversor.toEntity(model: model)
        entity.isFavorite = true
        try storage.insert(entity)
    }

    func delete(favorite model: BookModel) throws {
        let storage = try getStorage()
        if let existing = try storage.fetch(BookEntity.self).first(where: { $0.id == model.id }) {
            existing.isFavorite = false
            try storage.update()
            try validateDelete(book: existing, storage: storage)
        }
    }

    func add(cart model: BookModel) throws {
        let storage = try getStorage()
        if let existing = try storage.fetch(BookEntity.self).first(where: { $0.id == model.id }) {
            existing.inShoppingCart = true
            try storage.update()
            return
        }
        let entity = BookModelToEntityConversor.toEntity(model: model)
        entity.inShoppingCart = true
        try storage.insert(entity)
    }

    func delete(cart model: BookModel) throws {
        let storage = try getStorage()
        if let existing = try storage.fetch(BookEntity.self).first(where: { $0.id == model.id }) {
            existing.inShoppingCart = false
            try storage.update()
            try validateDelete(book: existing, storage: storage)
        }
    }

    func isFavorite(model: BookModel) throws -> Bool {
        let storage = try getStorage()
        return try storage.fetch(BookEntity.self).contains { $0.id == model.id && $0.isFavorite }
    }

    func inShoppingCart(model: BookModel) throws -> Bool {
        let storage = try getStorage()
        return try storage.fetch(BookEntity.self).contains { $0.id == model.id && $0.inShoppingCart }
    }

    private func validateDelete(book: BookEntity, storage: StorageRepositoryProtocol) throws {
        if !book.isFavorite && !book.inShoppingCart {
            try storage.delete(book)
        }
    }
}
