//
//  CustomNavigationBar.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct CustomNavigationBar: View {
    @Binding var path : NavigationPath
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
                    .resizable()
                    .frame(width: 28,height: 28)
                    .onTapGesture {
                        path.append(AppRoute.search)
                    }
                Image(.cart)
                    .onTapGesture {
                        path.append(AppRoute.cart)
                    }
                Image(.heart)
                    .onTapGesture {
                        path.append(AppRoute.favorites)
                    }
            }
        }
        .padding(.horizontal)
        .padding(.top, 10)
    }
}

#Preview {
    CustomNavigationBar(path:.constant(NavigationPath()))
}

