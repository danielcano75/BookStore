//
//  ShoppingCartView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct ShoppingCartView<ViewModel>: View where ViewModel: ShoppingCartViewModelable {
    @ObservedObject var viewModel: ViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        NavigationView {
            ZStack {
                DesignSystem.Colors.primary.ignoresSafeArea()
                switch viewModel.state {
                case .idle, .loading:
                    EmptyView()
                case .success(let books):
                    listOrEmpty(books)
                case .error(let message):
                    EmptyBookView(title: "There are no books.", message: message)
                }
            }
            .navigationTitle("Shopping cart")
            .toolbarTitleDisplayMode(.inlineLarge)
            .toolbar {
                ToolbarItem {
                    btnClose
                }
            }
            .foregroundStyle(DesignSystem.Colors.title)
            .font(.text)
            .onAppear {
                viewModel.fetch()
            }
        }
    }

    var btnClose: some View {
        Button(action: {
            dismiss()
        }) {
            Image(systemName: "xmark")
        }
    }

    private func listOrEmpty(_ books: [BookModel]) -> AnyView {
        if books.isEmpty {
            return AnyView(
                EmptyBookView(
                    title: "There are no books in the cart.",
                    message: "Try adding books to your shopping cart."
                )
            )
        }
        return AnyView(
            BookListView(books: books, onDelete: { viewModel.delete(cart: $0) }) {
                TotalFooterView(total: viewModel.total)
            }
        )
    }
}

#Preview {
    ShoppingCartView(viewModel: ShoppingCartViewModelPreviewable())
}
