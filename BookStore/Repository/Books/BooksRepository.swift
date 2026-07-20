//
//  BooksRepository.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation
import DataStorage
import SwiftData

final class BooksRepository: BooksRepositoryProtocol {
    private var storage: StorageRepositoryProtocol
    
    init() throws {
        let configuration = StorageConfiguration(schema: Schema([BookEntity.self]))
        self.storage = try StorageFactory.create(with: configuration)
    }
    
    func getFavorites() throws -> [BookEntity] {
        let books = try storage.fetch(BookEntity.self).filter({ $0.isFavorite })
        return books
    }
    
    func getShoppingCart() throws -> [BookEntity] {
        let books = try storage.fetch(BookEntity.self).filter({ $0.inShoppingCart })
        return books
    }
    
    func add(favorite entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = entity.isFavorite
            try storage.update()
            return
        }
        try storage.insert(entity)
    }

    func delete(favorite entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = entity.isFavorite
            try storage.update()
            try validateDelete(book: book)
        }
    }
    
    func add(cart entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.inShoppingCart = entity.inShoppingCart
            try storage.update()
            return
        }
        try storage.insert(entity)
    }
    
    func delete(cart entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.inShoppingCart = entity.inShoppingCart
            try storage.update()
            try validateDelete(book: book)
        }
    }
    
    func isFavorite(entity: BookEntity) throws -> Bool {
        let books = try storage.fetch(BookEntity.self)
        let isFavorite = books.contains { book in
            book.id == entity.id && book.isFavorite
        }
        return isFavorite
    }
    
    func inShoppingCart(entity: BookEntity) throws -> Bool {
        let books = try storage.fetch(BookEntity.self)
        let inShoppingCart = books.contains { book in
            book.id == entity.id && book.inShoppingCart
        }
        return inShoppingCart
    }
    
    private func validateDelete(book: BookEntity) throws {
        if !book.isFavorite && !book.inShoppingCart {
            try storage.delete(book)
        }
    }
}
