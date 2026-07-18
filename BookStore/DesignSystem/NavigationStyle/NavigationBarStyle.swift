//
//  NavigationBarStyle.swift
//  BookStore
//
//  Created by Daniel Cano on 7/17/26.
//

import UIKit

struct NavigationBarStyle {
    static func configure() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()

        appearance.backgroundColor = UIColor(named: "Primary")

        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: "Title") ?? .black,
            .font: UIFont(name: "NewYorkMedium-Semibold", size: 20) ?? .systemFont(ofSize: 20)
        ]

        appearance.largeTitleTextAttributes = [
            .foregroundColor: UIColor(named: "Title") ?? .black,
            .font: UIFont(name: "NewYorkLarge-Bold", size: 34)  ?? .systemFont(ofSize: 20)
        ]

        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
    }
}
