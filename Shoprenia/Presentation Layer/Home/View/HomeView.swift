//
//  HomeView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack(alignment: .leading){
            CustomNavigationBar()
            CouponsView()
            Text("Brands")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.app)
                
            BrandsGridView()
                .frame(height: 350)
        }
        .padding(.leading,15)
        .padding(.trailing,15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    HomeView()
}
