//
//  BooksRepositoryProtocol.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol BooksRepositoryProtocol {
    func getFavorites() throws -> [BookEntity]
    func getShoppingCart() throws -> [BookEntity]
    func add(favorite entity: BookEntity) throws
    func delete(favorite entity: BookEntity) throws
    func add(cart entity: BookEntity) throws
    func delete(cart entity: BookEntity) throws
    func isFavorite(entity: BookEntity) throws -> Bool
    func inShoppingCart(entity: BookEntity) throws -> Bool
}
