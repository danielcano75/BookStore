//
//  ValidateFavoriteUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

final class ValidateFavoriteUseCase: ValidateFavoriteUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(model: BookModel) throws -> Bool {
        let entity = BookModelToEntityConversor.toEntity(model: model)
        return try repository.isFavorite(entity: entity)
    }
}
