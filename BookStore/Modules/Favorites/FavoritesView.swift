//
//  FavoritesView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct FavoritesView<ViewModel>: View where ViewModel: FavoritesViewModelable {
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
                    listFavoritesOrEmpty(books)
                case .error(let message):
                    EmptyBookView(title: "No hay favoritos", message: message)
                }
            }
            .navigationTitle("Favorites")
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
    
    private func image(book: BookModel) -> some View {
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
                        .cornerRadius(10)
                    
                default:
                    Image("BookHolder")
                        .resizable()
                        .padding()
                }
            })
        }
        return AnyView(EmptyView())
    }
    
    private func listFavoritesOrEmpty(_ books: [BookModel]) -> AnyView {
        if books.isEmpty {
            return AnyView(
                EmptyBookView(
                    title: "No hay favoritos",
                    message: "Intenta agregar libros a tu listado de favoritos."
                )
            )
        }
        return AnyView(listBooks(books))
    }
    
    private func listBooks(_ books: [BookModel]) -> some View {
        List {
            ForEach(books) { book in
                HStack {
                    image(book: book)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 70, height: 70)
                    
                    content(book: book)
                        .padding(.trailing)
                    
                    Spacer()
                    
                    btnDelete(book: book)
                }
            }
        }
    }
    
    private func content(book: BookModel) -> some View {
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
    
    private func btnDelete(book: BookModel) -> some View {
        Button {
            viewModel.delete(favorite: book)
        } label: {
            Image(systemName: "trash.fill")
                .font(.title2)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    FavoritesView(viewModel: FavoritesViewModelPreviewable())
}
