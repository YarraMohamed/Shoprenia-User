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
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            OrderText(title: "Order Id:", value: order?.id.rawValue ?? " ")
            OrderText(title: "Total:", value: String(describing: order?.totalPrice.amount))
            OrderText(title: "Order Date:", value: String(describing: order?.processedAt))
        }
        .padding()
        .frame(width: 350,height: 150,alignment: .leading)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        }
        
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
