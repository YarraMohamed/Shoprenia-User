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
    var shipping: Int
    var code : String?
    var discount : Double
    @State private var selectedOption = "COD"
    @AppStorage("selectedCurrency") var selectedCurrency: String = "EGP"
    
    var availableOptions: [String] {
        if orderFees > 2000 {
            ["Apple Pay"]
        }else if orderFees < 100 {
            ["COD"]
        }else {
            ["COD", "Apple Pay"]
        }
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
                if orderFees > 1000 && selectedOption == "COD" {
                    selectedOption = "Apple Pay"
                }
            }

            VStack(spacing: 5) {
                Text("Total Price")
                    .font(.title2)
                    .fontWeight(.bold)
                Text(selectedCurrency == "USD" ?
                     "\(orderFees, specifier: "%.2f") USD"
                     : "\(orderFees, specifier: "%.2f") EGP"
                )
                    .font(.title2)
                    .foregroundColor(Color.app)
            }
            .padding(.vertical, 30)
            
            Button("Confirm Order") {
                if selectedOption == "Apple Pay" {
                    vm.startApplePay(amount: orderFees,currency: selectedCurrency)
                } else {
                    vm.confirmOrder(shipping: shipping, code: code, discount: discount)
                }
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
        }
        .onChange(of: vm.paymentSuccess){
            vm.confirmOrder(shipping: shipping, code: code, discount: discount)
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


