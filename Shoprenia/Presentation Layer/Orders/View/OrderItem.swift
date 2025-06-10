//
//  OrderItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct OrderItem: View {
    var body: some View {
        VStack(alignment: .leading,spacing: 5){
            OrderText(title: "Order Id:", value: "#58301")
            OrderText(title: "Total:", value: "120.00 EGP")
            OrderText(title: "Order Date:", value: "2025-06-09")
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
