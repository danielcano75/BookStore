//
//  BookDetailView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

struct BookDetailView<ViewModel>: View where ViewModel: BookDetailViewModelable {
    @ObservedObject var viewModel: ViewModel
    var book: BookModel
    
    var body: some View {
        ZStack {
            DesignSystem.Colors.primary.ignoresSafeArea()
            VStack {
                bookCover
                Spacer()
            }
            
            contentBook
            .ignoresSafeArea()
        }
        .onAppear {
            viewModel.validate(favorite: book)
            viewModel.validate(cart: book)
        }
        .font(.titleRegular)
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem {
                btnFavorites
            }
            ToolbarItem {
                btnShoppingCart
            }
        }
    }
    
    private var btnFavorites: some View {
        Button(action: {
            viewModel.toggle(favorite: book)
        }) {
            if viewModel.isFavorite {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
            } else {
                Image(systemName: "star")
            }
        }
    }
    
    private var btnShoppingCart: some View {
        Button(action: {
            viewModel.toggle(cart: book)
        }) {
            if viewModel.inShoppingCart {
                CartCheckView()
            } else {
                Image(systemName: "cart.badge.plus")
                    .symbolRenderingMode(.palette)
                    .foregroundStyle(.blue, .primary)
            }
        }
    }
    
    private var bookCover: some View {
        if let image = book.formats.image,
           let url = URL(string: image) {
            return AnyView(AsyncImage(
                url: url,
                transaction: Transaction(animation: .bouncy)
            ) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(10)
                    
                default:
                    Image("BookHolder")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                }
            })
        }
        return AnyView(EmptyView())
    }
    
    private var contentBook: some View {
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
    }
}

#Preview {
    NavigationStack {
        BookDetailFactory.create(book: .preview())
    }
}
