//
//  BooksViewModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI
import Combine

class BooksViewModel: BooksViewModelable {
    @Published var state: BooksState = .idle
    
    private var usecase: GetBooksUseCaseing
    
    init(usecase: GetBooksUseCaseing) {
        self.usecase = usecase
    }
    
    func fetch() {
        Task {
            do {
                let books = try await usecase.execute()
                state = .success(books)
            } catch {
                state = .error(error.localizedDescription)
            }
        }
    }
}
