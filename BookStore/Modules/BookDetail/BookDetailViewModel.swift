//
//  BookDetailViewModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import SwiftUI
import Combine

final class BookDetailViewModel: BookDetailViewModelable {
    @Published var isFavorite: Bool = false
    
    private var validateFavoriteUsecase: ValidateFavoriteUseCaseing
    private var addFavoriteUsecase: AddFavoriteUseCaseing
    private var deleteFavoriteUsecase: DeleteFavoriteUseCaseing
    
    init(validateFavoriteUsecase: ValidateFavoriteUseCaseing, addFavoriteUsecase: AddFavoriteUseCaseing, deleteFavoriteUsecase: DeleteFavoriteUseCaseing) {
        self.validateFavoriteUsecase = validateFavoriteUsecase
        self.addFavoriteUsecase = addFavoriteUsecase
        self.deleteFavoriteUsecase = deleteFavoriteUsecase
    }
}

extension BookDetailViewModel {
    func toggleFavorite(model: BookModel) {
        if isFavorite {
            delete(favorite: model)
        } else {
            add(favorite: model)
        }
    }
    
    private func delete(favorite model: BookModel) {
        do {
            try deleteFavoriteUsecase.execute(model: model)
            validateFavorite(model: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func add(favorite model: BookModel) {
        do {
            try addFavoriteUsecase.execute(model: model)
            validateFavorite(model: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func validateFavorite(model: BookModel) {
        withAnimation(.default) {
            do {
                isFavorite = try validateFavoriteUsecase.execute(model: model)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
}
