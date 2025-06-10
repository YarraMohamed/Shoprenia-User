//
//  AddressSelectionRow.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI

struct AddressSelectionRow: View {
    @Binding var isSelected: Bool
    var body: some View {
        VStack(alignment: .leading, spacing:8){
            Text("StreetName, Country")
            Text("PhoneNumber : 0123456789")
        }
        .onTapGesture {
            isSelected = true
        }
        .padding()
        .font(.title3)
        .fontWeight(.medium)
        .frame(width: 300,height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.app : Color.gray, lineWidth: isSelected ? 1 : 0.5)
        )
    }
}

#Preview {
    AddressSelectionRow(isSelected: .constant(false))
}
