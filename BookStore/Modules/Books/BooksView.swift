//
//  BooksView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

struct BooksView<ViewModel>: View where ViewModel: BooksViewModelable {
    @ObservedObject var viewModel: ViewModel
    @State private var sheet: BooksSheet? = nil
    @State private var searchText = ""
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        NavigationStack {
            ZStack {
                DesignSystem.Colors.primary.ignoresSafeArea()
                switch viewModel.state {
                case .idle:
                    Image("EmptyBooks")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding(.horizontal, 70)
                case .loading:
                    contentBooks(viewModel.booksLoading)
                        .redacted(reason: .placeholder)
                        .shimmer()
                case .success(let books):
                    contentBooks(books)
                case .error(let message):
                    Text(message)
                }
            }
            .navigationTitle("Books")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem {
                    btnFavorites
                }
                ToolbarItem {
                    btnShoppingCart
                }
            }
            .foregroundStyle(DesignSystem.Colors.title)
            .font(.textMedium)
            .sheet(item: $sheet) { type in
                switch type {
                case .favorites:
                    FavoritesFactory.create()
                case .shpppingCart:
                    ShoppingCartFactory.create()
                }
            }
        }
        .searchable(text: $searchText, placement: .navigationBarDrawer)
        .onChange(of: searchText) { _, text in
            if text.isEmpty {
                viewModel.state = .loading
                viewModel.searchClosed()
            } else {
                viewModel.search(text: text)
            }
        }
        .onAppear {
            viewModel.state = .loading
            viewModel.fetch()
        }
    }
    
    private var btnFavorites: some View {
        Button(action: {
            sheet = .favorites
        }) {
            Image(systemName: "heart.text.clipboard")
        }
    }
    
    private var btnShoppingCart: some View {
        Button(action: {
            sheet = .shpppingCart
        }) {
            Image(systemName: "cart.fill")
        }
    }
    
    private func contentBooks(_ books: [BookModel]) -> some View {
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailFactory.create(book: book)
                    } label: {
                        BookCellView(book: book)
                            .onAppear {
                                validateLast(book: book)
                            }
                    }
                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
    private func validateLast(book: BookModel) {
        viewModel.loadMoreIfNeeded(current: book)
    }
}

#Preview {
    BooksView(viewModel: BooksViewModelPreviewable())
}
