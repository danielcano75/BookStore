//
//  GetStoreBooksUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

final class GetStoreBooksUseCase: GetStoreBooksUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> [BookModel] {
        []
    }
}
