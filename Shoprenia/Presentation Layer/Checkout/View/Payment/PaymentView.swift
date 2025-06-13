//
//  PaymentView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct PaymentView: View {
    let orderFees : Double

    @State private var selectedOption = "COD"
        let options = ["COD", "Apple Pay"]
    var body: some View {
        VStack{
            Text("Choose your payment method")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.app)
            Image(.payment)
                .resizable()
                .frame(width: 450,height: 350)
            
            HStack {
                Picker("Options", selection: $selectedOption) {
                    ForEach(options, id: \.self) {
                        Text($0)
                            .font(.title3)
                            .fontWeight(.medium)
                            .foregroundColor(Color.app)
                    }
                }
                .pickerStyle(.segmented)
            }
            .padding(.horizontal,50)

            VStack(spacing:5){
                Text("Total Price")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("\(orderFees)")
                    .font(.title2)
                    .foregroundColor(Color.app)
            }
            .padding(.vertical,30)
            
            Button("Confirm Order"){
               
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            
        }
        .padding()
        .navigationBarTitle("Payment")
    }
}
//
//#Preview {
//    PaymentView()
//}
