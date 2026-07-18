//
//  BooksServiceProtocol.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

protocol BooksServiceProtocol {
    func execute() async throws -> BooksModel
}
