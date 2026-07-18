//
//  DeleteFavoriteUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

final class DeleteFavoriteUseCase: DeleteFavoriteUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(model: BookModel) throws {
        let entity = BookModelToEntityConversor.toEntity(model: model)
        try repository.delete(favorite: entity)
    }
}
