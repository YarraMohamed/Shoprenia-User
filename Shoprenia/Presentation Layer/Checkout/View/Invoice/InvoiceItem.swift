//
//  InvoiceItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 10/06/2025.
//

import SwiftUI

struct InvoiceItem: View {
    let line: CartLineItem
    
    var body: some View {
        HStack(spacing: 10) {
            if let imageURL = line.imageURL {
                AsyncImage(url: imageURL) { image in
                    image.resizable()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 100, height: 100)
                .scaledToFit()
            }

            VStack(alignment: .leading, spacing: 8) {
                Text(line.title)
                    .font(.system(size: 16))
                    .minimumScaleFactor(0.5)

                Text("Total Price: \(line.price) \(line.currency)")
                    .font(.system(size: 14))

                Text("Size and color: \(line.variantTitle)")
                    .font(.system(size: 14))

                HStack(spacing: 8) {
                    Text("Quantity:")
                    Text("\(line.quantity)")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .frame(width: 350, height: 180)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.blue.opacity(0.5), lineWidth: 0.5)
                .shadow(radius: 2)
        }
    }
}
