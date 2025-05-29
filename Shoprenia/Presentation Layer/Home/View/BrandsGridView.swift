//
//  BrandsGridView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI

struct BrandsGridView: View {
    var brands : [BrandDummyData] = [
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
        BrandDummyData(),BrandDummyData(),
    ]
    
    let columns : [GridItem] = [GridItem(.flexible()),GridItem(.flexible())]
    
    var body: some View {
        ScrollView{
            LazyVGrid(columns: columns,spacing: 20){
                ForEach(brands) { brand in
                    BrandView()
                }
            }
        }
    }
}

#Preview {
    BrandsGridView()
}
