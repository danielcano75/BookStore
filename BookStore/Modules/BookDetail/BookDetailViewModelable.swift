//
//  BookDetailViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import SwiftUI

protocol BookDetailViewModelable: ObservableObject {
    var isFavorite: Bool { get set }
    
    func toggleFavorite(model: BookModel)
    func validateFavorite(model: BookModel)
}
