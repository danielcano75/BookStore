//
//  GetFavoriteBooksUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

final class GetFavoriteBooksUseCase: GetFavoriteBooksUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() throws -> [BookModel] {
        let entities = try repository.getFavorites()
        let books = BookEntityToModelConversor.toModels(entities: entities)
        return books
    }
}
