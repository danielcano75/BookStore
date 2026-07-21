//
//  BooksService.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation
import Networking

enum BooksServiceErrors: Error {
    case missingSetupNetworking
}

final class BooksService: BooksServiceProtocol {
    static let shared = BooksService()
    
    private var networking: APIClientProtocol?
    
    func setup(base url: URL) {
        let configuration = NetworkConfiguration(baseURL: url)
        self.networking = NetworkFactory.create(with: configuration)
    }
    
    func getNetworking() throws -> APIClientProtocol {
        guard let networking else {
            throw BooksServiceErrors.missingSetupNetworking
        }
        return networking
    }
    
    func execute(endpoint: BooksEndpoint) async throws -> BooksModel {
        let networking = try getNetworking()
        let response = try await networking.execute(endpoint, as: BooksModel.self)
        return response.value
    }
}
