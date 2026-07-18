//
//  ValidateFavoriteUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol ValidateFavoriteUseCaseing {
    func execute(model: BookModel) throws -> Bool
}
