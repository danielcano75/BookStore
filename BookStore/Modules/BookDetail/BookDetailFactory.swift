//
//  BookDetailFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation
import SwiftUI

enum BookDetailFactory {
    static func create(book: BookModel) -> some View {
        let repository = BooksRepository.shared
        let validateFavorite = ValidateFavoriteUseCase(repository: repository)
        let addFavorite = AddFavoriteUseCase(repository: repository)
        let deleteFavorite = DeleteFavoriteUseCase(repository: repository)
        let validateCart = ValidateCartUseCase(repository: repository)
        let addCart = AddCartUseCase(repository: repository)
        let deleteCart = DeleteCartUseCase(repository: repository)
        let viewModel = BookDetailViewModel(
            validateFavoriteUsecase: validateFavorite,
            addFavoriteUsecase: addFavorite,
            deleteFavoriteUsecase: deleteFavorite,
            validateCartUsecase: validateCart,
            addCartUsecase: addCart,
            deleteCartUsecase: deleteCart
        )
        return BookDetailView(viewModel: viewModel, book: book)
    }
}
