//
//  BookDetailViewModelTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.viewModel))
struct BookDetailViewModelTests {

    private func makeViewModel(
        validateFavoriteResult: Bool = false,
        validateCartResult: Bool = false
    ) -> (BookDetailViewModel, MockValidateFavoriteUseCase, MockValidateCartUseCase,
          MockAddFavoriteUseCase, MockDeleteFavoriteUseCase,
          MockAddCartUseCase, MockDeleteCartUseCase) {
        let mockValidFav = MockValidateFavoriteUseCase()
        mockValidFav.stubbedResult = validateFavoriteResult
        let mockValidCart = MockValidateCartUseCase()
        mockValidCart.stubbedResult = validateCartResult
        let mockAddFav = MockAddFavoriteUseCase()
        let mockDelFav = MockDeleteFavoriteUseCase()
        let mockAddCart = MockAddCartUseCase()
        let mockDelCart = MockDeleteCartUseCase()

        let vm = BookDetailViewModel(
            validateFavoriteUsecase: mockValidFav,
            addFavoriteUsecase: mockAddFav,
            deleteFavoriteUsecase: mockDelFav,
            validateCartUsecase: mockValidCart,
            addCartUsecase: mockAddCart,
            deleteCartUsecase: mockDelCart
        )
        return (vm, mockValidFav, mockValidCart, mockAddFav, mockDelFav, mockAddCart, mockDelCart)
    }

    // MARK: - Validate Favorite

    @Test func validateFavorite_whenTrue_setsFavoriteTrue() throws {
        let (vm, _, _, _, _, _, _) = makeViewModel(validateFavoriteResult: true)
        vm.validate(favorite: .stub())
        #expect(vm.isFavorite == true)
    }

    @Test func validateFavorite_whenFalse_setsFavoriteFalse() throws {
        let (vm, _, _, _, _, _, _) = makeViewModel(validateFavoriteResult: false)
        vm.validate(favorite: .stub())
        #expect(vm.isFavorite == false)
    }

    // MARK: - Validate Cart

    @Test func validateCart_whenTrue_setsInShoppingCartTrue() throws {
        let (vm, _, _, _, _, _, _) = makeViewModel(validateCartResult: true)
        vm.validate(cart: .stub())
        #expect(vm.inShoppingCart == true)
    }

    @Test func validateCart_whenFalse_setsInShoppingCartFalse() throws {
        let (vm, _, _, _, _, _, _) = makeViewModel(validateCartResult: false)
        vm.validate(cart: .stub())
        #expect(vm.inShoppingCart == false)
    }

    // MARK: - Toggle Favorite

    @Test func toggleFavorite_whenNotFavorite_callsAddUseCase() throws {
        let (vm, _, _, mockAddFav, _, _, _) = makeViewModel(validateFavoriteResult: false)
        vm.isFavorite = false

        vm.toggle(favorite: .stub())

        #expect(mockAddFav.callCount == 1)
    }

    @Test func toggleFavorite_whenIsFavorite_callsDeleteUseCase() throws {
        let (vm, _, _, _, mockDelFav, _, _) = makeViewModel(validateFavoriteResult: false)
        vm.isFavorite = true

        vm.toggle(favorite: .stub())

        #expect(mockDelFav.callCount == 1)
    }

    // MARK: - Toggle Cart

    @Test func toggleCart_whenNotInCart_callsAddUseCase() throws {
        let (vm, _, _, _, _, mockAddCart, _) = makeViewModel(validateCartResult: false)
        vm.inShoppingCart = false

        vm.toggle(cart: .stub())

        #expect(mockAddCart.callCount == 1)
    }

    @Test func toggleCart_whenInCart_callsDeleteUseCase() throws {
        let (vm, _, _, _, _, _, mockDelCart) = makeViewModel(validateCartResult: false)
        vm.inShoppingCart = true

        vm.toggle(cart: .stub())

        #expect(mockDelCart.callCount == 1)
    }
}
