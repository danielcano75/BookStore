//
//  GetBooksUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

class GetBooksUseCase: GetBooksUseCaseing {
    private var service: BooksServiceProtocol?
    
    func setup(service: BooksServiceProtocol) {
        self.service = service
    }
    
    func execute(page: Int?, search: String?) async throws -> BooksModel {
        guard let service else {
            throw GetBooksUseErrors.service
        }
        let endpoint = BooksEndpoint(page: page, search: search)
        let books = try await service.execute(endpoint: endpoint)
        return books
    }
}

enum GetBooksUseErrors: Error {
    case service
}
