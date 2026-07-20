//
//  BooksViewModelPreviewable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Combine

class BooksViewModelPreviewable: BooksViewModelable {
    var state: BooksState = .idle
    var booksLoading: [BookModel] = []
    
    func fetch() {
        debugPrint("fetch preview")
    }
    
    func loadMoreIfNeeded(current book: BookModel) {
        debugPrint("Validate if needed load more")
    }
    
    func search(text: String) {
        debugPrint("Search \(text)")
    }
    
    func searchClosed() {
        debugPrint("search closed")
    }
}
