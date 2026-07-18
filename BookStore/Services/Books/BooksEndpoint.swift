//
//  BooksEndpoint.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation
import Networking

struct BooksEndpoint: Endpoint {
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
        nil
    }
    
    var body: Data? {
        nil
    }
}

