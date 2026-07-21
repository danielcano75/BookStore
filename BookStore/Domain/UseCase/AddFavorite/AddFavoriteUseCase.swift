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
        try repository.add(favorite: model)
    }
}
