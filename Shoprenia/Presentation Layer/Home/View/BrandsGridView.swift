//
//  BrandsGridView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI
import MobileBuySDK

struct BrandsGridView: View {
    let brands: [Storefront.Collection]
    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20){
                ForEach(brands, id: \.id) { brand in
                    BrandView(brand: brand)
                }
            }
        }
    }
}

#Preview {
   // BrandsGridView()
}
