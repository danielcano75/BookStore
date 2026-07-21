//
//  ConversorsTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.conversor))
struct ConversorsTests {

    // MARK: - BookEntityToModelConversor

    @Test func entityToModel_mapsId() {
        let entity = BookEntity(id: 7, title: "T", price: 5.0, currency: "USD",
                                author: "A", summary: "S", image: "img.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.id == 7)
    }

    @Test func entityToModel_mapsTitle() {
        let entity = BookEntity(id: 1, title: "Clean Architecture", price: 5.0, currency: "USD",
                                author: "A", summary: "S", image: "img.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.title == "Clean Architecture")
    }

    @Test func entityToModel_mapsPrice() {
        let entity = BookEntity(id: 1, title: "T", price: 19.99, currency: "USD",
                                author: "A", summary: "S", image: "img.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.price == 19.99)
    }

    @Test func entityToModel_mapsAuthorAsFirstPerson() {
        let entity = BookEntity(id: 1, title: "T", price: 5.0, currency: "USD",
                                author: "Robert C. Martin", summary: "S", image: "img.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.authors.first?.name == "Robert C. Martin")
    }

    @Test func entityToModel_mapsSummaryAsFirstElement() {
        let entity = BookEntity(id: 1, title: "T", price: 5.0, currency: "USD",
                                author: "A", summary: "Great book", image: "img.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.summaries.first == "Great book")
    }

    @Test func entityToModel_mapsImage() {
        let entity = BookEntity(id: 1, title: "T", price: 5.0, currency: "USD",
                                author: "A", summary: "S", image: "https://example.com/cover.jpg",
                                isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: entity)
        #expect(model.formats.image == "https://example.com/cover.jpg")
    }

    @Test func toModels_convertsAllEntities() {
        let entities = [
            BookEntity(id: 1, title: "Book1", price: 1.0, currency: "USD", author: "A1",
                       summary: "S1", image: "img1", isFavorite: false, inShoppingCart: false),
            BookEntity(id: 2, title: "Book2", price: 2.0, currency: "USD", author: "A2",
                       summary: "S2", image: "img2", isFavorite: false, inShoppingCart: false)
        ]
        let models = BookEntityToModelConversor.toModels(entities: entities)
        #expect(models.count == 2)
        #expect(models[0].id == 1)
        #expect(models[1].id == 2)
    }

    // MARK: - BookModelToEntityConversor

    @Test func modelToEntity_mapsId() {
        let model = BookModel.stub(id: 99)
        let entity = BookModelToEntityConversor.toEntity(model: model)
        #expect(entity.id == 99)
    }

    @Test func modelToEntity_mapsTitle() {
        let model = BookModel.stub(id: 1)
        let entity = BookModelToEntityConversor.toEntity(model: model)
        #expect(entity.title == "Book 1")
    }

    @Test func modelToEntity_mapsFirstAuthorName() {
        let model = BookModel.stub(id: 1)
        let entity = BookModelToEntityConversor.toEntity(model: model)
        #expect(entity.author == "Author")
    }

    @Test func modelToEntity_mapsFirstSummary() {
        let model = BookModel.stub(id: 1)
        let entity = BookModelToEntityConversor.toEntity(model: model)
        #expect(entity.summary == "Summary")
    }

    // MARK: - Round-trip

    @Test func roundTrip_entityToModelToEntity_preservesKeyFields() {
        let original = BookEntity(id: 42, title: "Round Trip", price: 12.0, currency: "USD",
                                  author: "RoundAuthor", summary: "RoundSummary",
                                  image: "round.jpg", isFavorite: false, inShoppingCart: false)
        let model = BookEntityToModelConversor.toModel(entity: original)
        let restored = BookModelToEntityConversor.toEntity(model: model)

        #expect(restored.id == original.id)
        #expect(restored.title == original.title)
        #expect(restored.price == original.price)
        #expect(restored.author == original.author)
        #expect(restored.summary == original.summary)
    }
}
