//
//  FavoritesFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

enum FavoritesFactory {
    static func create() -> some View {
        let repository = BooksRepository.shared
        let getFavoriteBooks = GetFavoriteBooksUseCase(repository: repository)
        let deleteFavorite = DeleteFavoriteUseCase(repository: repository)
        let viewModel = FavoritesViewModel(getFavoriteBooksUsecase: getFavoriteBooks, deleteFavoriteUsecase: deleteFavorite)
        return FavoritesView(viewModel: viewModel)
    }
}
