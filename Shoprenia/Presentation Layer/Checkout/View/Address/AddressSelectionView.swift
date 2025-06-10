//
//  AddressSelectionView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct AddressSelectionView: View {
    @Binding var path: NavigationPath
    @State var isSelected: Bool  = false
    var body: some View {
        VStack{
            List{
                ForEach(0..<4) { _ in
                   AddressSelectionRow(isSelected: $isSelected)
                        .frame(maxWidth: .infinity)
                }
            }
            .scrollContentBackground(.hidden)
            .padding(.bottom,20)
            
            Button("Checkout"){
                path.append(AppRouter.invoice)
            }
            .font(.system(size: 16, weight: .semibold))
            .foregroundStyle(.white)
            .frame(width: 250, height: 48)
            .background {
                RoundedRectangle(cornerRadius: 30)
                    .fill(.blue)
            }
        }
        .navigationTitle("Select Address")
        .toolbar{
            ToolbarItem{
                Button(action: {
                    path.append(AppRouter.addresses)
                }) {
                    Image(.plus)
                }
            }
        }
        
    }
}

#Preview {
    AddressSelectionView(path: .constant(NavigationPath()))
}
