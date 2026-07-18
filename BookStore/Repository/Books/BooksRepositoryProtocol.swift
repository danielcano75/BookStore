//
//  BooksRepositoryProtocol.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol BooksRepositoryProtocol {
    func add(favorite entity: BookEntity) throws
    func delete(favorite entity: BookEntity) throws
    func isFavorite(entity: BookEntity) throws -> Bool
}
