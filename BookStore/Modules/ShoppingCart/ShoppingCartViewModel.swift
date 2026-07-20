//
//  ShoppingCartViewModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI
import Combine

final class ShoppingCartViewModel: ShoppingCartViewModelable {
    @Published var state: ShoppingCartState = .idle
    @Published var total: Double = 0
    
    private let getCartBooksUsecase: GetCartBooksUseCaseing
    private let deleteCartUsecase: DeleteCartUseCaseing
    
    init(
        getCartBooksUsecase: GetCartBooksUseCaseing,
        deleteCartUsecase: DeleteCartUseCaseing
    ) {
        self.getCartBooksUsecase = getCartBooksUsecase
        self.deleteCartUsecase = deleteCartUsecase
    }
}

extension ShoppingCartViewModel {
    func fetch() {
        state = .loading
        total = 0
        do {
            let books = try getCartBooksUsecase.execute()
            state = .success(books)
            books.forEach { book in
                total += book.price
            }
        } catch {
            debugPrint(error.localizedDescription)
            state = .error(error.localizedDescription)
        }
    }
    
    func delete(cart book: BookModel) {
        do {
            try deleteCartUsecase.execute(model: book)
            fetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}

