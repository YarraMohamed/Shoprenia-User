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
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if isSelected {
                    Text("Selected")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()
            }

            Text("\(address?.firstName ?? "Name"), \(address?.address1 ?? "No Address")")
                .font(.body)
                .fontWeight(.semibold)

            Text(address?.phone ?? "No Phone")
                .foregroundColor(.gray)
                .font(.subheadline)

            HStack(alignment: .top) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.blue)
                Text("\(address?.address2 ?? ""), \(address?.country ?? "")")
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(isSelected ? Color.blue.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isSelected ? Color.blue.opacity(0.2) : Color.clear,
                    lineWidth: 1
                )
        )
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
