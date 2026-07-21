//
//  AppConfigurator.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import Foundation
import DataStorage
import Networking
import SwiftData

enum AppConfiguratorError: Error {
    case wrongBaseUrl
}

enum AppConfigurator {
    static func configure() throws {
        let repository = BooksRepository.shared
        try repository.setup(schema: Schema([BookEntity.self]))
        
        guard let url = URL(string: Constants.baseURL) else {
            throw AppConfiguratorError.wrongBaseUrl
        }
        let service = BooksService.shared
        service.setup(base: url)
    }
}
