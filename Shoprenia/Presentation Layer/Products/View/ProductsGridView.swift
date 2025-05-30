//
//  ProductsGridView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import SwiftUI

struct ProductsGridView: View {
    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20){
                ProductItem()
                ProductItem()
                ProductItem()
                ProductItem()
                ProductItem()
                ProductItem()
                ProductItem()
                ProductItem()
            }
        }
    }
}

#Preview {
    ProductsGridView()
}
