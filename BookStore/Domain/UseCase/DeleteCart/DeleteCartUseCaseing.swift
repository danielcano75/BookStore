//
//  DeleteCartUseCaseing.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation

protocol DeleteCartUseCaseing {
    func execute(model: BookModel) throws
}
