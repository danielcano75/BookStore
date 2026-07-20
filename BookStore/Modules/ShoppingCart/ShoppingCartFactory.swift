//
//  ShoppingCartFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

enum ShoppingCartFactory {
    static func create() -> some View {
        do {
            let repository = try BooksRepository()
            let getCartBooks = GetCartBooksUseCase(repository: repository)
            let deleteCart = DeleteCartUseCase(repository: repository)
            let viewModel = ShoppingCartViewModel(
                getCartBooksUsecase: getCartBooks,
                deleteCartUsecase: deleteCart
            )
            return AnyView(ShoppingCartView(viewModel: viewModel))
        } catch {
            return AnyView(EmptyBookView(title: "No hay libros en el carrito", message: ""))
        }
    }
}
