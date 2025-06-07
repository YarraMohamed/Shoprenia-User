

//  SettingList.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct SettingList: View {
    var body: some View {
        List {
            SettingsRowList()
        }.frame(width: 420 )
            
    }
}


#Preview {
    SettingList()
}

struct SettingsRowList: View {
    @State var rows = ["Currency", "Saved Addresses", "Help Center", "About us"]
    @AppStorage("selectedCurrency")  var selectedCurrency: String = "EGP"
    
    var body: some View {
        ForEach(rows, id: \.self) { row in
            if row == "Currency" {
                CurrencyPicker(selectedCurrency: $selectedCurrency, title: row)
            } else {
                NavigationLink(destination: SettingsDetailsView(title: row)) {
                    Text(row)
                        .font(.system(size: 14, weight: .medium, design: .serif))
                        .foregroundStyle(.blue)
                        .frame(height: 48)
                }
            }
        }
    }
}


struct SettingsDetailsView: View {
    let title: String

    var body: some View {
        VStack(alignment: .leading) {
            if title == "About us" {
                AboutUs()
            } else if title == "Help Center" {
                HelpCenter().offset(y: 70)
            } else if title == "Saved Addresses" {
                Addresses()
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}


