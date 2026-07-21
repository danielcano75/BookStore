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
}

final class BooksRepository: BooksRepositoryProtocol {
    static let shared = BooksRepository()
    
    private var storage: StorageRepositoryProtocol?
    
    func setup(schema: Schema) throws {
        let configuration = StorageConfiguration(schema: schema) 
        self.storage = try StorageFactory.create(with: configuration)
    }
    
    func getStoage() throws ->  StorageRepositoryProtocol {
        guard let storage else {
            throw BooksRepositoryErrors.missingSetupStorage
        }
        return storage
    }
    
    func getFavorites() throws -> [BookEntity] {
        let storage = try getStoage()
        let books = try storage.fetch(BookEntity.self).filter({ $0.isFavorite })
        return books
    }
    
    func getShoppingCart() throws -> [BookEntity] {
        let storage = try getStoage()
        let books = try storage.fetch(BookEntity.self).filter({ $0.inShoppingCart })
        return books
    }
    
    func add(favorite entity: BookEntity) throws {
        let storage = try getStoage()
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = entity.isFavorite
            try storage.update()
            return
        }
        try storage.insert(entity)
    }

    func delete(favorite entity: BookEntity) throws {
        let storage = try getStoage()
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = entity.isFavorite
            try storage.update()
            try validateDelete(book: book)
        }
    }
    
    func add(cart entity: BookEntity) throws {
        let storage = try getStoage()
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.inShoppingCart = entity.inShoppingCart
            try storage.update()
            return
        }
        try storage.insert(entity)
    }
    
    func delete(cart entity: BookEntity) throws {
        let storage = try getStoage()
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.inShoppingCart = entity.inShoppingCart
            try storage.update()
            try validateDelete(book: book)
        }
    }
    
    func isFavorite(entity: BookEntity) throws -> Bool {
        let storage = try getStoage()
        let books = try storage.fetch(BookEntity.self)
        let isFavorite = books.contains { book in
            book.id == entity.id && book.isFavorite
        }
        return isFavorite
    }
    
    func inShoppingCart(entity: BookEntity) throws -> Bool {
        let storage = try getStoage()
        let books = try storage.fetch(BookEntity.self)
        let inShoppingCart = books.contains { book in
            book.id == entity.id && book.inShoppingCart
        }
        return inShoppingCart
    }
    
    private func validateDelete(book: BookEntity) throws {
        if !book.isFavorite && !book.inShoppingCart {
            let storage = try getStoage()
            try storage.delete(book)
        }
    }
}
