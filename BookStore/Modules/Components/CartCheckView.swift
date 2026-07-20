//
//  CartCheckView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct CartCheckView: View {
    var body: some View {
        ZStack {
            Image(systemName: "cart")
            VStack(spacing: .zero) {
                HStack(spacing: .zero) {
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundStyle(.green)
                        .font(.custom(Font.Weight.regular.weight, size: 9))
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

#Preview {
    CartCheckView()
}
