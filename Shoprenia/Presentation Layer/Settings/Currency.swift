//
//  Currency.swift
//  Demo SWPro
//
//  Created by Reham on 29/05/2025.
//

import SwiftUI

struct CurrencyPicker: View {
    @Binding var selectedCurrency: String
    var title: String
    @State private var showingCurrencyPicker = false
        
    var body: some View {
        Button(action: {
            showingCurrencyPicker = true
        }) {
            HStack {
                Text(title)
                    .font(.system(size: 14, weight: .medium, design: .serif))
                    .foregroundStyle(.blue)
                
                Spacer()
                
                Text(selectedCurrency)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(.gray)
            }
            .frame(height: 48)
        }
        .actionSheet(isPresented: $showingCurrencyPicker) {
            ActionSheet(
                title: Text("Select Currency"),
                buttons: [
                    .default(Text("EGP")) { selectedCurrency = "EGP" },
                    .default(Text("USD")) { selectedCurrency = "USD" },
                    .cancel()
                ]
            )
        }
    }
}
