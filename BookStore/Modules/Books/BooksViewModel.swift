//
//  BooksViewModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI
import Combine

final class BooksViewModel: BooksViewModelable {
    @Published var state: BooksState = .idle
    private var books: [BookModel] = []
    private var page = 1
    private var hasMorePages = true
    @Published var booksLoading: [BookModel] = [ .preview(id: 1), .preview(id: 2), .preview(id: 3), .preview(id: 4), .preview(id: 5), .preview(id: 6) ]
    
    private let debouncer = SearchDebouncer()
    private var usecase: GetBooksUseCaseing
    
    init(usecase: GetBooksUseCaseing) {
        self.usecase = usecase
    }
}

extension BooksViewModel {
    @MainActor
    func fetch() {
        Task {
            do {
                let response = try await usecase.execute(page: page, search: nil)
                
                books.append(contentsOf: response.results)
                
                state = .success(books)
                
                page += 1
                hasMorePages = response.next != nil
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
    
    @MainActor
    func loadMoreIfNeeded(current book: BookModel) {
        guard hasMorePages else { return }
        
        guard let last = books.last else { return }
        
        guard last.id == book.id else { return }
        
        fetch()
    }
    
    @MainActor
    func search(text: String) {
        guard text.count >= 3 || text.isEmpty else {
            return
        }
        
        debouncer.submit(text: text) { [weak self] text in
            await self?.performSearch(text)
        }
    }
    
    @MainActor
    private func performSearch(_ text: String) async {
        page = 1
        hasMorePages = true
        do {
            if text.isEmpty {
                fetch()
            } else {
                try await searchBooks(text)
            }
        } catch {
            state = .error(error.localizedDescription)
        }
    }
    
    private func searchBooks(_ text: String) async throws {
        let response = try await usecase.execute(page: nil, search: text)

        books = response.results
        state = .success(books)
    }
    
    @MainActor
    func searchClosed() {
        
        books = []
        page = 1
        hasMorePages = true
        fetch()
    }
}
