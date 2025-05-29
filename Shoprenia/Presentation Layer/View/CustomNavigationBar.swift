//
//  CustomNavigationBar.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct CustomNavigationBar: View {
   // @Binding var showSearch: Bool
    var body: some View {
        HStack{
            Text("Shoprenia")
                .font(.title)
                .fontWeight(.semibold)
                .fontDesign(.serif)
                .foregroundColor(.app)
            Spacer()
            HStack(spacing: 20) {
                Image(.search)
                Image(.trolley)
                Image(.heart)
//                Button(action: {
//                                   showSearch = true
//                               }) {
//                                   Image(.search)
//                               }
//                NavigationLink(destination: PlaceholderView()) {
//                    Image(.trolley)
//                }
//                NavigationLink(destination: PlaceholderView()) {
//                    Image(.heart)
//                }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
   // CustomNavigationBar(showSearch: .constant(false))
    CustomNavigationBar()
}

