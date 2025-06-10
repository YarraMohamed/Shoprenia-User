//
//  InvoiceView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct InvoiceView: View {
    @Binding var path:NavigationPath
    let rows: [GridItem] = [GridItem(.flexible())]
    
    var body: some View {
        VStack{
            ScrollView(.horizontal) {
                LazyHGrid(rows: rows, spacing: 10) {
                    ForEach(0..<4) { index in
                        InvoiceItem()
                    }
                }
               
            }
            .padding(.vertical,20)
            .frame(maxWidth: .infinity,maxHeight: 250)
            
            HStack{
                Text("Original Total: ")
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                Text("100.00 EGP")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding()
            
            HStack{
                Text("Discount Code: ")
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                TextField("Enter Code", text: .constant(""))
                    .frame(width: 100)
                    .foregroundColor(.blue)
            }
            .padding()
            
            HStack{
                Text("Discounted Total: ")
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                Text("70.00 EGP")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding()
            
            HStack{
                Text("Location: ")
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                Text("Giza, Egypt")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding()
            
            HStack{
                Text("Phone: ")
                    .font(.system(size: 22, weight: .medium))
                Spacer()
                Text("0102847389")
                    .font(.system(size: 22, weight: .medium))
                    .foregroundColor(.blue)
            }
            .padding()
        
            Button("Place Order"){
                path.append(AppRouter.paymentMethods)
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
            .padding(.top,50)
            Spacer()
        }
        .navigationTitle("Invoice")
        .padding()
    }
}

#Preview {
    InvoiceView(path: .constant(NavigationPath()))
}
