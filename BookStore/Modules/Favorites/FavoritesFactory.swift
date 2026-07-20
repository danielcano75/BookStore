//
//  FavoritesFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

enum FavoritesFactory {
    static func create() -> AnyView {
        do {
            let repository = try BooksRepository()
            let getFavoriteBooks = GetFavoriteBooksUseCase(repository: repository)
            let deleteFavorite = DeleteFavoriteUseCase(repository: repository)
            let viewModel = FavoritesViewModel(getFavoriteBooksUsecase: getFavoriteBooks, deleteFavoriteUsecase: deleteFavorite)
            return AnyView(FavoritesView(viewModel: viewModel))
        } catch {
            return AnyView(EmptyBookView(title: "No hay favoritos", message: ""))
        }
    }
}
