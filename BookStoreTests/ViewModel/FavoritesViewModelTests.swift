//
//  FavoritesViewModelTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.viewModel))
struct FavoritesViewModelTests {

    @Test func fetch_success_setsSuccessState() throws {
        let books = [BookModel.stub(id: 1), BookModel.stub(id: 2)]
        let mockGet = MockGetFavoriteBooksUseCase(stubbedBooks: books)
        let mockDelete = MockDeleteFavoriteUseCase()
        let vm = FavoritesViewModel(getFavoriteBooksUsecase: mockGet, deleteFavoriteUsecase: mockDelete)

        vm.fetch()

        if case .success(let result) = vm.state {
            #expect(result.count == 2)
        } else {
            Issue.record("Expected .success state, got \(vm.state)")
        }
    }

    @Test func fetch_failure_setsErrorState() throws {
        let mockGet = MockGetFavoriteBooksUseCase(stubbedBooks: [], shouldThrow: true)
        let mockDelete = MockDeleteFavoriteUseCase()
        let vm = FavoritesViewModel(getFavoriteBooksUsecase: mockGet, deleteFavoriteUsecase: mockDelete)

        vm.fetch()

        if case .error = vm.state {
            // expected
        } else {
            Issue.record("Expected .error state, got \(vm.state)")
        }
    }

    @Test func delete_callsDeleteUseCase_thenFetches() throws {
        let book = BookModel.stub(id: 1)
        let mockGet = MockGetFavoriteBooksUseCase(stubbedBooks: [])
        let mockDelete = MockDeleteFavoriteUseCase()
        let vm = FavoritesViewModel(getFavoriteBooksUsecase: mockGet, deleteFavoriteUsecase: mockDelete)

        vm.delete(favorite: book)

        #expect(mockDelete.callCount == 1)
        #expect(mockGet.callCount == 1) // fetch() called after delete
    }
}
