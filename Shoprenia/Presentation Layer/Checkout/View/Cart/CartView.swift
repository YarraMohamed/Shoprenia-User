//
//  CartView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct CartView: View {
    @Binding var path : NavigationPath
    @State var totalPrice: Int = 1200
    @State var quantity: Int = 1
    @State var showAlert: Bool = false
    var body: some View {
        VStack{
            List{
                ForEach(0..<4) { _ in
                    CartProductView(quantity: $quantity, showAlert: $showAlert)
                }

            }
            .listStyle(.plain)
            .scrollContentBackground(.hidden)
            .padding(.bottom,20)
            
            Text("Total is: \(totalPrice) EGP")
                .font(.title2)
                .fontWeight(.semibold)
                .padding(.bottom,10)
            Button("Get Them"){
                
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            
        }
        .alert("Are you sure to delete this item?", isPresented: $showAlert) {
            Button("No",role: .cancel) {
                print("Cancel")
            }
            Button("Delete",role: .destructive){
                print("Delete")
            }
        }
        .padding(.horizontal,20)
        .navigationTitle("Cart")

    }
}

#Preview {
    CartView(path: .constant(NavigationPath()))
}
