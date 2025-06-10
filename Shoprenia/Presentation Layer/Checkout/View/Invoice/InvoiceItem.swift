//
//  InvoiceItem.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 10/06/2025.
//

import SwiftUI

struct InvoiceItem: View {
    var body: some View {
        HStack(spacing: 10) {
            Image(.brandImg)
                .resizable()
                .frame(width: 120,height: 150)
                .scaledToFit()
            VStack(alignment: .leading, spacing: 8){
                Text("VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE")
                    .font(.headline)
                    .minimumScaleFactor(0.5)
                Text("20.00 EGP")
                Text("Small / Red")
                HStack(spacing:8){
                    Text("Quantity:")
                    Text("5")
                        .font(.headline)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding()
        .frame(width: 350,height: 180)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 0.5)
                .shadow(radius: 5)
        }
    }
}

#Preview {
    InvoiceItem()
}
