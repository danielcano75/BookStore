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
    
    func add(favorite entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = true
            try storage.update()
            return
        }
        try storage.insert(entity)
    }
    
    func delete(favorite entity: BookEntity) throws {
        if let book = try storage.fetch(BookEntity.self).first(where: { $0.id == entity.id }) {
            book.isFavorite = false
            try storage.update()
        }
    }
    
    func isFavorite(entity: BookEntity) throws -> Bool {
        let books = try storage.fetch(BookEntity.self)
        let isFavorite = books.contains { book in
            book.id == entity.id && book.isFavorite
        }
        return isFavorite
    }
}
