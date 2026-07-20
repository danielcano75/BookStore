//
//  BooksEndpoint.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation
import Networking

struct BooksEndpoint: Endpoint {
    let page: Int?
    let search: String?
    
    var path: String {
        "/books"
    }
    
    var method: HTTPMethod {
        .get
    }
    
    var headers: HTTPHeaders {
        [:]
    }
    
    var queryItems: [URLQueryItem]? {
        var items: [URLQueryItem] = []
        
        if let page, page > 0 {
            items.append(
                .init(name: "page", value: "\(page)")
            )
        }
        
        if let search, !search.isEmpty {
            items.append(
                .init(name: "search", value: search)
            )
        }
        
        return items
    }
    
    var body: Data? {
        nil
    }
}

