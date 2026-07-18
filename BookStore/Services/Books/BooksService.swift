//
//  BooksService.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation
import Networking

class BooksService: BooksServiceProtocol {
    private var networking: APIClientProtocol
    
    init() {
        let url = URL(string: "https://gutendex.com")!
        let configuration = NetworkConfiguration(baseURL: url)
        self.networking = NetworkFactory.create(with: configuration)
    }
    
    func execute() async throws -> BooksModel {
        let endpoint = BooksEndpoint()
        let response = try await networking.execute(endpoint, as: BooksModel.self)
        return response.value
    }
}
