//
//  BookDetailView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

struct BookDetailView: View {
    var book: BookModel
    
    var body: some View {
        ZStack {
            DesignSystem.Colors.primary.ignoresSafeArea()
            VStack {
                if let image = book.formats.image, let url = URL(string: image) {
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    } placeholder: {
                        HStack {
                            Spacer()
                            ProgressView().progressViewStyle(.circular)
                            Spacer()
                        }
                    }
                }
                Spacer()
            }
            
            VStack(spacing: .zero) {
                Spacer()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Authors:")
                        .font(.title)
                    ForEach(book.authors.indices, id: \.self) { index in
                        Text(book.authors[index].name)
                        HStack(spacing: .zero) {
                            if let birthYear = book.authors[index].birthYear {
                                Text("\(birthYear)")
                            }
                            if let deathYear = book.authors[index].deathYear {
                                Text(" - \(deathYear)")
                            }
                        }
                    }
                    
                    HStack {
                        Text("Price:")
                            .font(.title)
                        Text("\(book.price.formatted(.currency(code: book.currency)))")
                            .lineLimit(1)
                    }
                    
                    Text("Summaries:")
                        .font(.title)
                    ForEach(book.summaries.indices, id: \.self) { index in
                        Text(book.summaries[index])
                    }
                }
                .padding()
                .padding(.bottom)
                .foregroundStyle(DesignSystem.Colors.title)
                .background(
                    RoundedRectangle(
                        cornerRadius: 20)
                    .foregroundStyle(DesignSystem.Colors.secondary)
                )
            }
            .ignoresSafeArea()
        }
        .font(.titleRegular)
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "heart")
                }
            }
            ToolbarItem {
                Button(action: {}) {
                    Image(systemName: "cart.badge.plus")
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        BookDetailView(book: .preview())
    }
}
