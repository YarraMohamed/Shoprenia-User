//
//  ProductItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import SwiftUI

struct ProductItem: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topTrailing) {
                Image(.productImg)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 160)
                    .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16,topTrailingRadius: 16))
                   
                Image(.heartUnfilled)
                    .foregroundColor(.blue)
                    .padding(10)
            }.padding(0)
            VStack(alignment: .leading, spacing: 5) {
                Text("VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .minimumScaleFactor(0.7)

                Text("$120.00")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.blue)
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 10)
        }
        .frame(width: 180, height: 250)
        .background(Color(.appGrey))
        .scaledToFill()
        .cornerRadius(16)
        .clipped()
        
    }
}

#Preview {
    ProductItem()
}
