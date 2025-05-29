//
//  BrandView.swift
//  Test-Shoprenia
//
//  Created by Yara Mohamed on 28/05/2025.
//

import SwiftUI
import MobileBuySDK

struct BrandView: View {
    var brand : Storefront.Collection?
    var body: some View {
        VStack{
            AsyncImage(url: brand?.image?.url) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 150, height: 150)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 160)
                        .clipped()
                case .failure:
                    Image(.brandImg)
                        .resizable()
                        .scaledToFit()
                        .frame(width:150, height: 160)
                        .clipped()
                @unknown default:
                    EmptyView()
                }
            }
            Spacer()
            Text(brand?.title ?? "")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(.black)
                .fontDesign(.rounded)
                .padding(.bottom,10)
            
        }.frame(width: 170,height: 200)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 3)
    }
}

#Preview {
    BrandView()
}
