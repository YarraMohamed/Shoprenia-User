//
//  CartProductView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct CartProductView: View {
    @Binding var quantity: Int 
    @Binding var showAlert : Bool
    var body: some View {
        VStack(alignment: .leading,spacing: 8) {
            Text("VANS |AUTHENTIC | LO PRO | BURGANDY/WHITE")
                .font(.headline)
                .minimumScaleFactor(0.5)
            Text("20.00 EGP")
            Text("Small / Red")
            HStack{
                Text("Quantity")
                Spacer()
                
                Button(action: {
                    if quantity > 1 {
                        quantity -= 1
                    }else{
                        showAlert = true
                    }
                }) {
                    Image(.minus)
                        .foregroundColor(.gray)
                }
                
                Text("\(quantity)")
                    .font(.headline)
                    .fontWeight(.semibold)
                
                Button(action: {
                    quantity += 1
                }) {
                    Image(.plus)
                        .foregroundColor(.gray)
                }
                
            }
        }
        .padding()
        .frame(width: 300,height: 180)
        .overlay {
            RoundedRectangle(cornerRadius: 15)
                .stroke(Color.gray, lineWidth: 1)
        }
    }
}

#Preview {
    CartProductView(quantity: .constant(1) ,showAlert: .constant(false))
}
