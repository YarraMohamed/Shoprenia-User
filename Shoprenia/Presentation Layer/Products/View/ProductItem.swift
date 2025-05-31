//
//  ProductItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import SwiftUI
import MobileBuySDK

struct ProductItem: View {
    var product : Storefront.Product?
    var body: some View {
        VStack(alignment: .leading, spacing: 5) {
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: product?.images.nodes.first?.url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 150, height: 160)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 180, height: 160)
                            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16,topTrailingRadius: 16))

                    case .failure:
                        Image(.productPlaceholder)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 180, height: 160)
                            .clipShape(UnevenRoundedRectangle(topLeadingRadius: 16,topTrailingRadius: 16))
                    @unknown default:
                        EmptyView()
                    }
                }
                Image(.heartUnfilled)
                    .foregroundColor(.blue)
                    .padding(10)
            }
            .frame(width: 180, height: 160)
            VStack(alignment: .leading, spacing: 8) {
                Text(product?.title ?? "")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.black)
                    .lineLimit(3)
                    .minimumScaleFactor(0.5)
                Text("\(String(describing: product?.variants.nodes.first?.price.amount ?? 0)) EGP")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)

            }
            .padding(.horizontal,8)
            .frame(width: 180,alignment: .leading)
            
            Spacer()

            
        }
        .edgesIgnoringSafeArea(.all)
        .frame(width: 180, height: 240)
        .background(.appGrey)
        .scaledToFill()
        .cornerRadius(16)
        .clipped()
        .shadow(radius:4)
        
    }
}

#Preview {
    ProductItem()
}
