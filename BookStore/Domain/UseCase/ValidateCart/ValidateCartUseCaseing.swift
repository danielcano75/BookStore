//
//  ValidateCartUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

protocol ValidateCartUseCaseing {
    func execute(model: BookModel) throws -> Bool
}
