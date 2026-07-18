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
    
    func execute() async throws -> [BookModel] {
        guard let service else {
            throw GetBooksUseErrors.service
        }
        
        let books = try await service.execute()
        return books.results
    }
}

enum GetBooksUseErrors: Error {
    case service
}
