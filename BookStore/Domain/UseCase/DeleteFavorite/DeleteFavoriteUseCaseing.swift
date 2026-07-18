//
//  DeleteFavoriteUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/18/26.
//

import Foundation

protocol DeleteFavoriteUseCaseing {
    func execute(model: BookModel) throws
}
