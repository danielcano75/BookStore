//
//  BooksFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

enum BooksFactory {
    static func create() -> some View {
        let repository = BooksRepository.shared
        let getBooks = GetBooksUseCase(repository: repository)
        let getCartBooks = GetCartBooksUseCase(repository: repository)
        let viewModel = BooksViewModel(getBooksUsecase: getBooks, getCartBooksUsecase: getCartBooks)
        return BooksView(viewModel: viewModel)
    }
}

