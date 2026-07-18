//
//  BookModelToEntityConversor.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

enum BookModelToEntityConversor {
    static func toEntities(models: [BookModel]) -> [BookEntity] {
        models.map { model in
            toEntity(model: model)
        }
    }
    
    static func toEntity(model: BookModel) -> BookEntity {
        BookEntity(
            id: model.id,
            title: model.title,
            price: model.price,
            currency: model.currency,
            author: model.authors.first?.name ?? "",
            summary: model.summaries.first ?? "",
            image: model.formats.image ?? "",
            isFavorite: false,
            inShoppingCart: false
        )
    }
}
