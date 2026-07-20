//
//  AddCartUseCase.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

final class AddCartUseCase: AddCartUseCaseing {
    private var repository: BooksRepositoryProtocol
    
    init(repository: BooksRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(model: BookModel) throws {
        let entity = BookModelToEntityConversor.toEntity(model: model)
        entity.inShoppingCart = true
        try repository.add(cart: entity)
    }
}
