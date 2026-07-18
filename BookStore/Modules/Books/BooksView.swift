//
//  BooksView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI

struct BooksView<ViewModel>: View where ViewModel: BooksViewModelable {
    @ObservedObject var viewModel: ViewModel
    
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
                    EmptyView()
                case .loading:
                    ProgressView()
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
                    Button(action: {}) {
                        Image(systemName: "bolt.heart.fill")
                    }
                }
                ToolbarItem {
                    Button(action: {}) {
                        Image(systemName: "cart.fill")
                    }
                }
            }
            .foregroundStyle(DesignSystem.Colors.title)
            .font(.textMedium)
        }
        .onAppear {
            viewModel.fetch()
        }
    }
    
    private func contentBooks(_ books: [BookModel]) -> some View {
        return ScrollView(.vertical, showsIndicators: false) {
            LazyVGrid(columns: columns) {
                ForEach(books) { book in
                    NavigationLink {
                        BookDetailView(book: book)
                    } label: {
                        BookCellView(book: book)
                    }

                }
            }
        }
        .padding(.top)
        .padding(.horizontal)
    }
}

#Preview {
    //BooksView(viewModel: BooksViewModelPreviewable())
    BooksFactory.create()
}
