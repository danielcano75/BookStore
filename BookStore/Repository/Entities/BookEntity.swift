//
//  BookEntity.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation
import SwiftData

@Model
final class BookEntity {
    @Attribute(.unique)
    var id: Int
    var title: String
    var price: Double
    var currency: String
    var author: String
    var summary: String
    var image: String
    var isFavorite: Bool
    var inShoppingCart: Bool
    
    init(id: Int, title: String, price: Double, currency: String, author: String, summary: String, image: String, isFavorite: Bool, inShoppingCart: Bool) {
        self.id = id
        self.title = title
        self.price = price
        self.currency = currency
        self.author = author
        self.summary = summary
        self.image = image
        self.isFavorite = isFavorite
        self.inShoppingCart = isFavorite
    }
}
