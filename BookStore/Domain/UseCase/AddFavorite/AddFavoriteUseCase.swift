//
//  AddFavoriteUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

final class AddFavoriteUseCase: AddFavoriteUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(model: BookModel) throws {
        let entity = BookModelToEntityConversor.toEntity(model: model)
        entity.isFavorite = true
        try repository.add(favorite: entity)
    }
}
