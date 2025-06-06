//
//  AddCard.swift
//  Shoprenia
//
//  Created by Reham on 03/06/2025.
//

import SwiftUI

struct AddressCardView: View {
    let isDefault: Bool
    let name: String
    let phone: String
    let address: String
    var onEdit: () -> Void
    var onDelete: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            HStack {
                if isDefault {
                    Text("Default")
                        .font(.caption)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.blue.opacity(0.9))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }

                Spacer()

                HStack(spacing: 16) {
                    Button("Delete", action: onDelete)
                        .foregroundColor(.blue.opacity(0.9))

                    Button("Edit", action: onEdit)
                        .foregroundColor(.blue.opacity(0.9))
                }
                .font(.subheadline)
            }

            Text(name)
                .font(.body)
                .fontWeight(.semibold)

            Text(phone)
                .foregroundColor(.gray)
                .font(.subheadline)

            HStack(alignment: .top) {
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.blue)
                Text(address)
                    .font(.subheadline)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding()
        .background(isDefault ? Color.blue.opacity(0.1) : Color(.systemGray6))
        .cornerRadius(12)
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(
                    isDefault ? Color.blue.opacity(0.2) : Color.clear,
                    lineWidth: 1
                )
        )
    }
}
