//
//  BooksRepositoryProtocol.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol BooksRepositoryProtocol {
    func fetchBooks(page: Int?, search: String?) async throws -> BooksModel
    func getFavorites() throws -> [BookModel]
    func getShoppingCart() throws -> [BookModel]
    func add(favorite model: BookModel) throws
    func delete(favorite model: BookModel) throws
    func add(cart model: BookModel) throws
    func delete(cart model: BookModel) throws
    func isFavorite(model: BookModel) throws -> Bool
    func inShoppingCart(model: BookModel) throws -> Bool
}
