//
//  BookStoreApp.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import SwiftUI
import SwiftData

@main
struct BookStoreApp: App {
    init() {
        NavigationBarStyle.configure()
    }

    var body: some Scene {
        WindowGroup {
            BooksFactory.create()
        }
    }
}
