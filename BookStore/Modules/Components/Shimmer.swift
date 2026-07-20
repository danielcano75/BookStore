//
//  Shimmer.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct Shimmer: ViewModifier {

    @State private var offset: CGFloat = -1

    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in

                    LinearGradient(
                        colors: [
                            .clear,
                            .white.opacity(0.55),
                            .clear
                        ],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                    .frame(width: geo.size.width * 0.4)
                    .offset(x: offset * geo.size.width * 2)
                    .onAppear {
                        withAnimation(
                            .linear(duration: 1)
                                .repeatForever(autoreverses: false)
                        ) {
                            offset = 1.5
                        }
                    }
                }
            }
            .mask(content)
    }
}

extension View {
    func shimmer() -> some View {
        modifier(Shimmer())
    }
}
