//
//  BookInfoView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct BookInfoView: View {
    let book: BookModel

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Title:")
                    .font(.textSemiBold)
                Text(book.title)
                    .lineLimit(1)
            }
            if let author = book.authors.first {
                HStack {
                    Text("Author:")
                        .font(.textSemiBold)
                    Text(author.name)
                        .lineLimit(1)
                }
            }
            HStack {
                Text("Price:")
                    .font(.textSemiBold)
                Text("\(book.price.formatted(.currency(code: book.currency)))")
                    .lineLimit(1)
            }
        }
    }
}

#Preview {
    BookInfoView(book: .preview())
        .padding()
}
