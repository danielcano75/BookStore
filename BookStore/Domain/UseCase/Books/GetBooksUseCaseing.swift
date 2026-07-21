//
//  GetBooksUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

protocol GetBooksUseCaseing {
    func execute(page: Int?, search: String?) async throws -> BooksModel
}
