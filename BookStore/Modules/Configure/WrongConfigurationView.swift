//
//  WrongConfigurationView.swift
//  BookStore
//
//  Created by Daniel Cano on 7/20/26.
//

import SwiftUI

struct WrongConfigurationView: View {
    var body: some View {
        ZStack {
            DesignSystem.Colors.primary.ignoresSafeArea()
            
            VStack(spacing: 12) {
                Image("WrongConfiguration")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                Text("Something Went Wrong")
                    .font(.title3)
                Text("We couldn't initialize the required services to continue. Please try again or restart the application.")
            }
            .font(.title)
            .multilineTextAlignment(.center)
            .foregroundStyle(DesignSystem.Colors.title)
            .padding(.horizontal, 40)
        }
    }
}

#Preview {
    WrongConfigurationView()
}
