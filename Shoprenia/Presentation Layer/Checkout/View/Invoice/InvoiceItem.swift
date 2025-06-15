//
//  InvoiceItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 10/06/2025.
//

import SwiftUI

struct InvoiceItem: View {
    let line: CartLineItem
    @State private var convertedPrice: Double? = nil
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    
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

                Text(
                    selectedCurrency == "USD"
                     ? "Total Price: \(String(format: "%.2f", convertedPrice ?? 0)) USD"
                    : "Total Price: \(String(describing: line.price)) EGP"
                 )
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
        .onAppear{
            if selectedCurrency == "USD" {
                let priceEGP = line.price
                let priceDouble = NSDecimalNumber(decimal: priceEGP).doubleValue
                convertedPrice = convertEGPToUSD(priceDouble)
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
    
    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        return amount * exchangeRate
    }
}
