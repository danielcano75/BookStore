//
//  BooksViewModelPreviewable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Combine

class BooksViewModelPreviewable: BooksViewModelable {
    var state: BooksState = .idle
    
    func fetch() {
        debugPrint("fetch preview")
    }
}
