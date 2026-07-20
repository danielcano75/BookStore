//
//  GetFavoriteBooksUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

protocol GetFavoriteBooksUseCaseing {
    func execute() throws -> [BookModel]
}
