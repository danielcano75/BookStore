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
                    listShoppingCartOrEmpty(books)
                case .error(let message):
                    EmptyBookView(title: "No hay favoritos", message: message)
                }
            }
            .navigationTitle("Carrito")
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
    
    
    private func listShoppingCartOrEmpty(_ books: [BookModel]) -> AnyView {
        if books.isEmpty {
            return AnyView(
                EmptyBookView(
                    title: "No hay libros en el carrito",
                    message: "Intenta agregar libros a tu carrito de compras."
                )
            )
        }
        return AnyView(listBooks(books))
    }
    
    private func listBooks(_ books: [BookModel]) -> some View {
        VStack {
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
            
            HStack {
                Spacer()
                Text("Total: ")
                Text("\(viewModel.total.formatted(.currency(code: "USD")))")
            }
            .font(.title3)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(DesignSystem.Colors.background)
                    .ignoresSafeArea()
            )
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
            viewModel.delete(cart: book)
        } label: {
            Image(systemName: "trash.fill")
                .font(.title2)
                .foregroundStyle(.red)
        }
    }
}

#Preview {
    ShoppingCartView(viewModel: ShoppingCartViewModelPreviewable())
}
