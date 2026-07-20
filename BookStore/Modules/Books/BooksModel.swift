//
//  BooksModel.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

enum BooksState {
    case idle
    case loading
    case success([BookModel])
    case error(String)
}

enum BooksSheet: Int, Identifiable {
    case favorites = 1
    case shpppingCart = 2
    
    var id: Int {
        rawValue
    }
}

// MARK: - Root
struct BooksModel: Decodable, Sendable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [BookModel]
}

// MARK: - Book

struct BookModel: Decodable, Sendable, Identifiable {
    let id: Int
    let title: String
    var price = Double.random(in: 4.99...39.99)
    var currency = "USD"
    let authors: [Person]
    let summaries: [String]
    let editors: [Person]
    let translators: [Person]
    let subjects: [String]
    let bookshelves: [String]
    let languages: [String]
    let copyright: Bool
    let mediaType: String
    let formats: Formats
    let downloadCount: Int

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case authors
        case summaries
        case editors
        case translators
        case subjects
        case bookshelves
        case languages
        case copyright
        case mediaType = "media_type"
        case formats
        case downloadCount = "download_count"
    }
}

// MARK: - Person

struct Person: Decodable, Sendable {
    let name: String
    let birthYear: Int?
    let deathYear: Int?

    enum CodingKeys: String, CodingKey {
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

// MARK: - Formats

struct Formats: Decodable, Sendable {
    let html: String?
    let epub: String?
    let mobi: String?
    let rdf: String?
    let image: String?
    let zip: String?
    let textUTF8: String?
    let textASCII: String?

    enum CodingKeys: String, CodingKey {
        case html = "text/html"
        case epub = "application/epub+zip"
        case mobi = "application/x-mobipocket-ebook"
        case rdf = "application/rdf+xml"
        case image = "image/jpeg"
        case zip = "application/octet-stream"
        case textUTF8 = "text/plain; charset=utf-8"
        case textASCII = "text/plain; charset=us-ascii"
    }
}
