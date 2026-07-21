//
//  BookListRowView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct BookListRowView: View {
    let book: BookModel
    let onDelete: (BookModel) -> Void

    var body: some View {
        HStack {
            BookCoverView(book: book)
                .aspectRatio(contentMode: .fit)
                .frame(width: 70, height: 70)

            BookInfoView(book: book)
                .padding(.trailing)

            Spacer()

            Button {
                onDelete(book)
            } label: {
                Image(systemName: "trash.fill")
                    .font(.title2)
                    .foregroundStyle(.red)
            }
        }
    }
}

#Preview {
    BookListRowView(book: .preview(), onDelete: { _ in })
        .padding()
}
