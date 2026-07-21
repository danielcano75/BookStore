//
//  BooksViewModelTests.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation
import Testing
@testable import BookStore

@Suite(.tags(.viewModel))
@MainActor
struct BooksViewModelTests {

    @Test func fetch_success_setsSuccessState() async throws {
        let book = BookModel.stub(id: 1)
        let mockGetBooks = MockGetBooksUseCase(result: .success(.stub(results: [book])))
        let mockGetCart = MockGetCartBooksUseCase()
        let vm = BooksViewModel(getBooksUsecase: mockGetBooks, getCartBooksUsecase: mockGetCart)

        vm.fetch()
        await Task.yield()

        if case .success(let books) = vm.state {
            #expect(books.count == 1)
            #expect(books.first?.id == 1)
        } else {
            Issue.record("Expected .success state, got \(vm.state)")
        }
    }

    @Test func fetch_failure_setsErrorState() async throws {
        let mockGetBooks = MockGetBooksUseCase(result: .failure(URLError(.notConnectedToInternet)))
        let mockGetCart = MockGetCartBooksUseCase()
        let vm = BooksViewModel(getBooksUsecase: mockGetBooks, getCartBooksUsecase: mockGetCart)

        vm.fetch()
        await Task.yield()

        if case .error = vm.state {
            // expected
        } else {
            Issue.record("Expected .error state, got \(vm.state)")
        }
    }

    @Test func shoppingCartBooks_setsCount() throws {
        let mockGetBooks = MockGetBooksUseCase()
        let mockGetCart = MockGetCartBooksUseCase(stubbedBooks: [.stub(id: 1), .stub(id: 2)])
        let vm = BooksViewModel(getBooksUsecase: mockGetBooks, getCartBooksUsecase: mockGetCart)

        vm.shoppingCartBooks()

        #expect(vm.shoppingCartBooksCount == 2)
    }

    @Test func fetch_callsGetBooksUseCase() async throws {
        let mockGetBooks = MockGetBooksUseCase()
        let mockGetCart = MockGetCartBooksUseCase()
        let vm = BooksViewModel(getBooksUsecase: mockGetBooks, getCartBooksUsecase: mockGetCart)

        vm.fetch()
        await Task.yield()

        #expect(mockGetBooks.callCount == 1)
    }
}
