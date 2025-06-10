//  SettingList.swift
//  Demo SWPro
//
//  Created by Reham on 28/05/2025.
//

import SwiftUI

struct SettingList: View {
    let viewModel: AddressViewModel
    @Binding var path: NavigationPath

    var body: some View {
        List {
            SettingsRowList(viewModel:viewModel,path: $path)
        }
//        .scrollContentBackground(.hidden)
        .frame(width: 420 )
            
    }
}

struct SettingsRowList: View {
    let viewModel: AddressViewModel
    @Binding var path: NavigationPath

    @State var rows = ["Currency", "Saved Addresses", "Help Center", "About us"]
    @AppStorage("selectedCurrency")  var selectedCurrency: String = "EGP"
    
    var body: some View {
        ForEach(rows, id: \.self) { row in
            if row == "Currency" {
                CurrencyPicker(selectedCurrency: $selectedCurrency, title: row)
            } else {
                HStack{
                    Button(row){
                        switch row {
                        case "Help Center":
                            path.append(AppRouter.HelpCenter)
                        case "About us":
                            path.append(AppRouter.AboutUs)
                        default:
                            path.append(AppRouter.addresses)
                        }
                    }
                    Spacer()
                    Image(systemName: "chevron.right")
                }

                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.blue)
                .frame(height: 48)
                    
////                SettingsDetailsView(title: row, viewModel: viewModel)
//                NavigationLink(destination: SettingsDetailsView(title: row, viewModel: viewModel,path: <#T##Binding<NavigationPath>#>)) {
//                    Text(row)
//                        .font(.system(size: 14, weight: .medium, design: .serif))
//                        .foregroundStyle(.blue)
//                        .frame(height: 48)
//                }
            }
        }
    }
}


struct SettingsDetailsView: View {
    let title: String
    let viewModel: AddressViewModel
    @Binding var path:NavigationPath

    var body: some View {
        VStack(alignment: .leading) {
            if title == "About us" {
                AboutUs()
            } else if title == "Help Center" {
                HelpCenter().offset(y: 70)
            } else if title == "Saved Addresses" {
                Addresses(viewModel: viewModel,path:$path)
            }
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .padding()
    }
}


