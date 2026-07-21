//
//  SplashView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            DesignSystem.Colors.primary.ignoresSafeArea()
            Image("Logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(.horizontal, 40)
                .padding(.bottom, 50)
        }
    }
}

#Preview {
    SplashView()
}
