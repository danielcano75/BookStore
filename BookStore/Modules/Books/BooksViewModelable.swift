//
//  BooksViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

protocol BooksViewModelable: ObservableObject {
    var state: BooksState { get set }
    var shoppingCartBooksCount: Int { get set }
    var booksLoading: [BookModel] { get set }
    
    @MainActor func fetch()
    @MainActor func loadMoreIfNeeded(current book: BookModel)
    @MainActor func search(text: String)
    @MainActor func searchClosed()
    
    func shoppingCartBooks()
}
