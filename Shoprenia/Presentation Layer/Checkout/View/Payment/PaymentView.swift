//
//  PaymentView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct PaymentView: View {
    @ObservedObject var vm : PaymentViewModel
    @Binding var path : NavigationPath
    let orderFees : Double
    @State private var selectedOption = "COD"
    
    var availableOptions: [String] {
        orderFees > 5000 ? ["Apple Pay"] : ["COD", "Apple Pay"]
    }
    
    var body: some View {
        VStack {
            Text("Choose your payment method")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.app)
            
            Image(.payment)
                .resizable()
                .frame(width: 450, height: 350)
            
            Picker("Options", selection: $selectedOption) {
                ForEach(availableOptions, id: \.self) { option in
                    Text(option)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(Color.app)
                }
            }
            .pickerStyle(.segmented)
            .padding(.horizontal, 50)
            .onChange(of: orderFees) { _ in
                if orderFees > 5000 && selectedOption == "COD" {
                    selectedOption = "Apple Pay"
                }
            }

            VStack(spacing: 5) {
                Text("Total Price")
                    .font(.title2)
                    .fontWeight(.bold)
                Text("\(orderFees, specifier: "%.2f")")
                    .font(.title2)
                    .foregroundColor(Color.app)
            }
            .padding(.vertical, 30)
            
            Button("Confirm Order") {
                vm.confirmOrder()
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
        }
        .alert("Order Confirmed", isPresented: $vm.isSuccess, actions: {
            Button("OK") {
                path.removeLast(4)
            }
        }, message: {
            Text("Your order has been successfully placed and is being processed.")
        })
        .padding()
        .navigationBarTitle("Payment")
    }
}


