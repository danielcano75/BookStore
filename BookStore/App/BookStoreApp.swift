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
    @State private var appState: BookStoreState = .idle
    
    init() {
        NavigationBarStyle.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                switch appState {
                case .idle, .configure:
                    SplashView()
                case .ready:
                    BooksFactory.create()
                case .failure:
                    WrongConfigurationView()
                }
            }
            .preferredColorScheme(.light)
            .onAppear {
                configure()
            }
        }
    }
    
    private func configure() {
        appState = .configure
        do {
            try AppConfigurator.configure()
            appState = .ready
        } catch {
            appState = .failure
        }
    }
}
