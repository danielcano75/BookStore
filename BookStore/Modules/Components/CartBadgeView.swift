//
//  CartBadgeView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct CartBadgeView: View {
    @Binding var count: Int
    
    var body: some View {
        ZStack {
            Image(systemName: "cart.fill")
            if count > .zero {
                VStack(spacing: .zero) {
                    HStack(spacing: .zero) {
                        Spacer()
                        Image(systemName: "\(count).circle.fill")
                            .foregroundStyle(.red)
                            .font(.custom(Font.Weight.medium.weight, size: 12))
                            .background(
                                Circle().foregroundStyle(DesignSystem.Colors.primary)
                            )
                            .padding(.leading)
                    }
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    CartBadgeView(count: .constant(10))
}
