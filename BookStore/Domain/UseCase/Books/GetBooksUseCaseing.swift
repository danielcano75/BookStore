//
//  GetBooksUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

protocol GetBooksUseCaseing {
    func setup(service: BooksServiceProtocol)
    func execute() async throws -> [BookModel]
}
