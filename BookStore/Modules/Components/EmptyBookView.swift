//
//  EmptyBookView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct EmptyBookView: View {
    var title: String
    var message: String
    
    var body: some View {
        VStack(spacing: 12) {
            Image("EmptyBooks")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(title)
                .font(.title3)
            Text(message)
                .font(.titleRegular)
        }
        .multilineTextAlignment(.center)
        .foregroundStyle(.primary)
        .padding(.horizontal, 70)
    }
}

#Preview {
    EmptyBookView(title: "Ops!", message: "Sucedio algo")
}
