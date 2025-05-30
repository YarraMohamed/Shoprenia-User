//
//  ProductsView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import SwiftUI

struct ProductsView: View {
    var vendor : String?
    var body: some View {
        VStack{
           Divider()
            HStack{
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.gray)
                TextField("Search", text: .constant(""))
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
            .padding()
            ProductsGridView()
        }.navigationTitle(vendor ?? "Products")
      
    }
}

#Preview {
    ProductsView()
}
