//
//  ShoppingCartModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

enum ShoppingCartState {
    case idle
    case loading
    case success([BookModel])
    case error(String)
}
