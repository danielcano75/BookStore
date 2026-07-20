//
//  BookDetailViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import SwiftUI

protocol BookDetailViewModelable: ObservableObject {
    var isFavorite: Bool { get set }
    var inShoppingCart: Bool { get set }
    
    func toggle(favorite model: BookModel)
    func validate(favorite model: BookModel)
    
    func toggle(cart model: BookModel)
    func validate(cart model: BookModel)
}
