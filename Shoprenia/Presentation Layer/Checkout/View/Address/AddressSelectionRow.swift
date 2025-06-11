//
//  AddressSelectionRow.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 09/06/2025.
//

import SwiftUI
import MobileBuySDK

struct AddressSelectionRow: View {
    var isSelected: Bool
    var address: Storefront.MailingAddress?

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(address?.address1 ?? "No Address"), \(address?.city ?? "No City")")
            Text("Phone Number: \(address?.phone ?? "No Phone Number")")
        }
        .padding()
        .font(.title3)
        .fontWeight(.medium)
        .frame(width: 300, height: 150)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(isSelected ? Color.app : Color.gray, lineWidth: isSelected ? 1 : 0.5)
        )
    }
}


#Preview {
   // AddressSelectionRow(isSelected: .constant(false))
}
