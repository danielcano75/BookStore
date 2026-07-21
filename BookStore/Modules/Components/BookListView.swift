//
//  BookListView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct BookListView<Footer: View>: View {
    let books: [BookModel]
    let onDelete: (BookModel) -> Void
    @ViewBuilder let footer: () -> Footer

    var body: some View {
        VStack {
            List {
                ForEach(books) { book in
                    BookListRowView(book: book, onDelete: onDelete)
                }
            }
            footer()
        }
    }
}

#Preview {
    BookListView(
        books: [.preview()],
        onDelete: { _ in }
    ) {
        EmptyView()
    }
}
