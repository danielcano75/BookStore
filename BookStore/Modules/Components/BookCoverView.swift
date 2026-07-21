//
//  BookCoverView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct BookCoverView: View {
    let book: BookModel

    var body: some View {
        if let imageString = book.formats.image,
           let url = URL(string: imageString) {
            AsyncImage(url: url, transaction: Transaction(animation: .bouncy)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .cornerRadius(10)
                default:
                    Image("BookHolder")
                        .resizable()
                        .padding()
                }
            }
        }
    }
}

#Preview {
    BookCoverView(book: .preview())
        .aspectRatio(contentMode: .fit)
        .frame(width: 70, height: 70)
}
