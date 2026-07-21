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
        try repository.delete(favorite: model)
    }
}
