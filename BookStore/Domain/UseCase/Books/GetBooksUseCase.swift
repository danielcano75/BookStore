//
//  GetBooksUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

class GetBooksUseCase: GetBooksUseCaseing {
    private let repository: BooksRepositoryProtocol

    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }

    func execute(page: Int?, search: String?) async throws -> BooksModel {
        return try await repository.fetchBooks(page: page, search: search)
    }
}
