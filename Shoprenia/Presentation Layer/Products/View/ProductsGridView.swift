//
//  ProductsGridView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import SwiftUI
import MobileBuySDK

struct ProductsGridView: View {
    let products: [Storefront.Product]
    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20){
                ForEach(products, id: \.id) { product in
                    ProductItem(product: product)
                }.padding(.top,5)
            }
        }
    }
}

#Preview {
   // ProductsGridView()
}

