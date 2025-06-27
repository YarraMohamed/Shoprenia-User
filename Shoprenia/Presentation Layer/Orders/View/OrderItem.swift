//
//  OrderItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct OrderItem: View {
    var order : Storefront.Order?
    @State private var convertedPrice: Double? = nil
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    var body: some View {
        HStack{
            VStack(alignment: .leading,spacing: 5){
                OrderText(title: "Order Id:", value: order?.name ?? " ")
                OrderText(title: "Total:",
                          value: selectedCurrency == "USD" ?
                          "\(String(describing: convertedPrice ?? 0)) USD"
                          :"\(String(describing: order?.totalPrice.amount ?? 0)) EGP")
                OrderText(title: "Order Date:", value: String(String(describing: order?.processedAt ?? Date()).split(separator: " ").first ?? " "))
            }
            Spacer()
            VStack(alignment: .trailing){
                Image(.order)
                    .resizable()
                    .frame(width: 50,height: 50)
            }
        }
        .onAppear{
            if selectedCurrency == "USD" {
                let priceEGP = order?.totalPrice.amount
                let priceDouble = NSDecimalNumber(decimal: priceEGP ?? 0.0).doubleValue
                convertedPrice = convertEGPToUSD(priceDouble)
            }
        }
        .padding()
        .frame(width: 350,height: 150,alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        }
        
    }
    
    private func convertEGPToUSD(_ amount: Double) -> Double {
        let exchangeRate: Double = 1.0 / 49.71
        let result = amount * exchangeRate
        return Double(round(100 * result) / 100)
    }
}

#Preview {
    OrderItem()
}

struct OrderText : View {
    var title: String
    var value : String
    var body: some View {
        HStack{
            Text(title)
                .fontWeight(.semibold)
                .foregroundColor(Color.app)
            Text(value)
            
        }
        .font(.title3)
    }
}
