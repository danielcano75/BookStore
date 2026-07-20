//
//  ShoppingCartViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

protocol ShoppingCartViewModelable: ObservableObject {
    var state: ShoppingCartState { get set }
    var total: Double { get set }
    
    func fetch()
    func delete(cart book: BookModel)
}
