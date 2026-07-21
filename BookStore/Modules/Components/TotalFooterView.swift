//
//  TotalFooterView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct TotalFooterView: View {
    let total: Double

    var body: some View {
        HStack {
            Spacer()
            Text("Total: ")
            Text("\(total.formatted(.currency(code: "USD")))")
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

#Preview {
    TotalFooterView(total: 29.99)
}
