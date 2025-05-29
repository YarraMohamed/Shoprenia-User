//
//  CustomNavigationBar.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct CustomNavigationBar: View {
    var body: some View {
        HStack{
            Text("Shoprenia")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.serif)
                .foregroundColor(.app)
            Spacer()
            HStack(spacing: 20) {
                NavigationLink(destination: PlaceholderView()) {
                    Image(.search)
                }
                NavigationLink(destination: PlaceholderView()) {
                    Image(.trolley)
                }
                NavigationLink(destination: PlaceholderView()) {
                    Image(.heart)
                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    CustomNavigationBar()
}

