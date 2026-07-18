//
//  BooksViewModelable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

protocol BooksViewModelable: ObservableObject {
    var state: BooksState { get set }
    
    func fetch()
}
