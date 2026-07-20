//
//  BookCellView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

struct BookCellView: View {
    var book: BookModel
    
    var body: some View {
        VStack {
            ZStack {
                if let image = book.formats.image,
                   let url = URL(string: image) {
                    AsyncImage(
                        url: url,
                        transaction: Transaction(animation: .bouncy)
                    ) { phase in
                        switch phase {
                        case .success(let image):
                            image
                                .resizable()
                        default:
                            Image("BookHolder")
                                .resizable()
                                .padding()
                        }
                    }
                    .cornerRadius(22)
                }
            }
            .frame(height: 150)
            
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
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
        }
        .background(
            RoundedRectangle(cornerRadius: 20)
                .foregroundStyle(DesignSystem.Colors.background)
        )
    }
}

#Preview {
    BookCellView(book: .preview())
        .frame(width: 200)
}
