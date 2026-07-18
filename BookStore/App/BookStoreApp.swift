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
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Item.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            BooksFactory.create()
                .onAppear {
                    for family in UIFont.familyNames.sorted() {
                        print("Family: \(family)")
                        for font in UIFont.fontNames(forFamilyName: family) {
                            print("   \(font)")
                        }
                    }
                }
        }
        .modelContainer(sharedModelContainer)
    }
}
