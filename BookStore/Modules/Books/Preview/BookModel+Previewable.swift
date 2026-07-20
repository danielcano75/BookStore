//
//  BookModel+Previewable.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import Foundation

// MARK: - Peviewable
extension BookModel {
    static func preview(id: Int = 2701) -> Self {
        BookModel(
            id: id,
            title: "Moby Dick; Or, The Whale",
            authors: [
                Person(
                    name: "Melville, Herman",
                    birthYear: 1819,
                    deathYear: 1891
                )
            ],
            summaries: [
                """
                "Moby Dick; Or, The Whale" by Herman Melville is an epic novel published in 1851. Sailor Ishmael narrates the obsessive quest of Captain Ahab, who commands the whaling ship Pequod in pursuit of Moby Dick, a giant white sperm whale that destroyed his leg. Ahab's monomaniacal hunt for vengeance drives the ship and its diverse crew across the world's oceans, blending realistic whaling details with profound explorations of good, evil, fate, and human nature in this cornerstone of American literature. (This is an automatically generated summary.)
                """
            ],
            editors: [],
            translators: [],
            subjects: [
                "Adventure stories",
                "Ahab, Captain (Fictitious character) -- Fiction",
                "Mentally ill -- Fiction",
                "Psychological fiction",
                "Sea stories",
                "Ship captains -- Fiction",
                "Whales -- Fiction",
                "Whaling -- Fiction",
                "Whaling ships -- Fiction"
            ],
            bookshelves: [
                "Best Books Ever Listings",
                "Category: Adventure",
                "Category: American Literature",
                "Category: Classics of Literature",
                "Category: Novels"
            ],
            languages: [
                "en"
            ],
            copyright: false,
            mediaType: "Text",
            formats: Formats(
                html: "https://www.gutenberg.org/ebooks/2701.html.images",
                epub: "https://www.gutenberg.org/ebooks/2701.epub3.images",
                mobi: "https://www.gutenberg.org/ebooks/2701.kf8.images",
                rdf: "https://www.gutenberg.org/ebooks/2701.rdf",
                image: "https://www.gutenberg.org/cache/epub/2701/pg2701.cover.medium.jpg",
                zip: "https://www.gutenberg.org/cache/epub/2701/pg2701-h.zip",
                textUTF8: "https://www.gutenberg.org/ebooks/2701.txt.utf-8",
                textASCII: ""
            ),
            downloadCount: 160_099
        )
    }
}
