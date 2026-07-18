//
//  AddFavoriteUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol AddFavoriteUseCaseing {
    func execute(model: BookModel) throws
}
