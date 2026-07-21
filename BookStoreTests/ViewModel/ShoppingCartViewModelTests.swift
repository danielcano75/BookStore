//
//  ShoppingCartViewModelTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Testing
@testable import BookStore

@Suite(.tags(.viewModel))
struct ShoppingCartViewModelTests {

    @Test func fetch_success_setsSuccessState() throws {
        let books = [BookModel.stub(id: 1), BookModel.stub(id: 2)]
        let mockGet = MockGetCartBooksUseCase(stubbedBooks: books)
        let mockDelete = MockDeleteCartUseCase()
        let vm = ShoppingCartViewModel(getCartBooksUsecase: mockGet, deleteCartUsecase: mockDelete)

        vm.fetch()

        if case .success(let result) = vm.state {
            #expect(result.count == 2)
        } else {
            Issue.record("Expected .success state, got \(vm.state)")
        }
    }

    @Test func fetch_success_calculatesTotal() throws {
        let books = [BookModel.stub(id: 1, price: 10.0), BookModel.stub(id: 2, price: 5.0)]
        let mockGet = MockGetCartBooksUseCase(stubbedBooks: books)
        let mockDelete = MockDeleteCartUseCase()
        let vm = ShoppingCartViewModel(getCartBooksUsecase: mockGet, deleteCartUsecase: mockDelete)

        vm.fetch()

        #expect(vm.total == 15.0)
    }

    @Test func fetch_failure_setsErrorState() throws {
        let mockGet = MockGetCartBooksUseCase(stubbedBooks: [], shouldThrow: true)
        let mockDelete = MockDeleteCartUseCase()
        let vm = ShoppingCartViewModel(getCartBooksUsecase: mockGet, deleteCartUsecase: mockDelete)

        vm.fetch()

        if case .error = vm.state {
            // expected
        } else {
            Issue.record("Expected .error state, got \(vm.state)")
        }
    }

    @Test func delete_callsDeleteUseCase_thenFetches() throws {
        let book = BookModel.stub(id: 1)
        let mockGet = MockGetCartBooksUseCase(stubbedBooks: [])
        let mockDelete = MockDeleteCartUseCase()
        let vm = ShoppingCartViewModel(getCartBooksUsecase: mockGet, deleteCartUsecase: mockDelete)

        vm.delete(cart: book)

        #expect(mockDelete.callCount == 1)
        #expect(mockGet.callCount == 1) // fetch() called after delete
    }
}
