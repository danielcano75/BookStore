//
//  BookEntityToModelConversor.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

enum BookEntityToModelConversor {
    static func toModels(entities: [BookEntity]) -> [BookModel] {
        entities.map { entity in
            toModel(entity: entity)
        }
    }
    
    static func toModel(entity: BookEntity) -> BookModel {
        BookModel(
            id: entity.id,
            title: entity.title,
            price: entity.price,
            currency: entity.currency,
            authors: [
                Person(name: entity.author, birthYear: nil, deathYear: nil)
            ],
            summaries: [ entity.summary ],
            editors: [],
            translators: [],
            subjects: [],
            bookshelves: [],
            languages: [],
            copyright: false,
            mediaType: "",
            formats: Formats(html: nil, epub: nil, mobi: nil, rdf: nil, image: entity.image, zip: nil, textUTF8: nil, textASCII: nil),
            downloadCount: 0
        )
    }
}
