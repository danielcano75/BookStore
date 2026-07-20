//
//  ShoppingCartViewModelPreviewable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Combine

final class ShoppingCartViewModelPreviewable: ShoppingCartViewModelable {
    var state: ShoppingCartState = .idle
    var total: Double = 0
    
    func fetch() {
        debugPrint("Load Books")
        state = .success([ .preview() ])
    }
    
    func delete(cart book: BookModel) {
        debugPrint("Delete \(book.title)")
    }
}
