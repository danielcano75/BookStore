//
//  FavoritesViewModelPreviewable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Combine

final class FavoritesViewModelPreviewable: FavoritesViewModelable {
    var state: FavoritesState = .idle
    
    func fetch() {
        debugPrint("Load Books")
        
        state = .success([ .preview() ])
    }
    
    func delete(favorite book: BookModel) {
        debugPrint("Delete \(book.title)")
    }
}
