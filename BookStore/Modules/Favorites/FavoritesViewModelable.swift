//
//  FavoritesViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

protocol FavoritesViewModelable: ObservableObject {
    var state: FavoritesState { get set }
    
    func fetch()
    func delete(favorite book: BookModel)
}
