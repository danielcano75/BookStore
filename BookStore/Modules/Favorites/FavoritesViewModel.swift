//
//  FavoritesViewModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI
import Combine

final class FavoritesViewModel: FavoritesViewModelable {
    @Published var state: FavoritesState = .idle
    
    private let getFavoriteBooksUsecase: GetFavoriteBooksUseCaseing
    private let deleteFavoriteUsecase: DeleteFavoriteUseCaseing
    
    init(
        getFavoriteBooksUsecase: GetFavoriteBooksUseCaseing,
        deleteFavoriteUsecase: DeleteFavoriteUseCaseing
    ) {
        self.getFavoriteBooksUsecase = getFavoriteBooksUsecase
        self.deleteFavoriteUsecase = deleteFavoriteUsecase
    }
}

extension FavoritesViewModel {
    func fetch() {
        state = .loading
        do {
            let books = try getFavoriteBooksUsecase.execute()
            state = .success(books)
        } catch {
            debugPrint(error.localizedDescription)
            state = .error(error.localizedDescription)
        }
    }
    
    func delete(favorite book: BookModel) {
        do {
            try deleteFavoriteUsecase.execute(model: book)
            fetch()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
