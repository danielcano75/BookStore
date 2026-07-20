//
//  ValidateCartUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

final class ValidateCartUseCase: ValidateCartUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(model: BookModel) throws -> Bool {
        let entity = BookModelToEntityConversor.toEntity(model: model)
        return try repository.inShoppingCart(entity: entity)
    }
}
