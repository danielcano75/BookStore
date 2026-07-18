//
//  BooksFactory.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

enum BooksFactory {
    static func create() -> some View {
        let service = BooksService()
        let usecase = GetBooksUseCase()
        usecase.setup(service: service)
        let viewModel = BooksViewModel(usecase: usecase)
        return BooksView(viewModel: viewModel)
    }
}

