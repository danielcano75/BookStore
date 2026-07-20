//
//  BooksFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

enum BooksFactory {
    static func create() -> AnyView {
        do {
            let repository = try BooksRepository()
            let service = BooksService()
            let getBooks = GetBooksUseCase()
            getBooks.setup(service: service)
            let getCartBooks = GetCartBooksUseCase(repository: repository)
            let viewModel = BooksViewModel(getBooksUsecase: getBooks, getCartBooksUsecase: getCartBooks)
            return AnyView(BooksView(viewModel: viewModel))
        } catch {
            return AnyView(EmptyBookView(title: "Something happened while loading the Startup", message: ""))
        }
    }
}

