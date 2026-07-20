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
    @Published var inShoppingCart: Bool = false
    
    private var validateFavoriteUsecase: ValidateFavoriteUseCaseing
    private var addFavoriteUsecase: AddFavoriteUseCaseing
    private var deleteFavoriteUsecase: DeleteFavoriteUseCaseing
    private var validateCartUsecase: ValidateCartUseCaseing
    private var addCartUsecase: AddCartUseCaseing
    private var deleteCartUsecase: DeleteCartUseCaseing
    
    init(
        validateFavoriteUsecase: ValidateFavoriteUseCaseing, 
        addFavoriteUsecase: AddFavoriteUseCaseing,
        deleteFavoriteUsecase: DeleteFavoriteUseCaseing,
        validateCartUsecase: ValidateCartUseCaseing,
        addCartUsecase: AddCartUseCaseing,
        deleteCartUsecase: DeleteCartUseCaseing
    ) {
        self.validateFavoriteUsecase = validateFavoriteUsecase
        self.addFavoriteUsecase = addFavoriteUsecase
        self.deleteFavoriteUsecase = deleteFavoriteUsecase
        self.validateCartUsecase = validateCartUsecase
        self.addCartUsecase = addCartUsecase
        self.deleteCartUsecase = deleteCartUsecase
    }
}

extension BookDetailViewModel {
    func toggle(favorite model: BookModel) {
        if isFavorite {
            delete(favorite: model)
        } else {
            add(favorite: model)
        }
    }
    
    func validate(favorite model: BookModel) {
        withAnimation(.default) {
            do {
                isFavorite = try validateFavoriteUsecase.execute(model: model)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func toggle(cart model: BookModel) {
        if inShoppingCart {
            delete(cart: model)
        } else {
            add(cart: model)
        }
    }
    
    func validate(cart model: BookModel) {
        withAnimation(.default) {
            do {
                inShoppingCart = try validateCartUsecase.execute(model: model)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    private func delete(favorite model: BookModel) {
        do {
            try deleteFavoriteUsecase.execute(model: model)
            validate(favorite: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func add(favorite model: BookModel) {
        do {
            try addFavoriteUsecase.execute(model: model)
            validate(favorite: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func delete(cart model: BookModel) {
        do {
            try deleteCartUsecase.execute(model: model)
            validate(cart: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    private func add(cart model: BookModel) {
        do {
            try addCartUsecase.execute(model: model)
            validate(cart: model)
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
}
