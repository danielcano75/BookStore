//
//  ShoppingCartFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

enum ShoppingCartFactory {
    static func create() -> some View {
        let repository = BooksRepository.shared
        let getCartBooks = GetCartBooksUseCase(repository: repository)
        let deleteCart = DeleteCartUseCase(repository: repository)
        let viewModel = ShoppingCartViewModel(
            getCartBooksUsecase: getCartBooks,
            deleteCartUsecase: deleteCart
        )
        return ShoppingCartView(viewModel: viewModel)
    }
}
