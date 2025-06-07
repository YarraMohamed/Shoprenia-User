//
//  CategoriesView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import SwiftUI

struct CategoriesView: View {
    @ObservedObject var viewModel: CategoriesViewModel
    @Binding var path : NavigationPath
    @State var isMenuExpanded = false

    let options = ["Men", "Women", "Kids","Sale"]
    
    var body: some View {
        VStack{
            CustomNavigationBar(path: $path)
            
            Picker("Options", selection: $viewModel.selectedCategory) {
                ForEach(options, id: \.self) { option in
                    Text(option).tag(option)
                }
            }
            .padding(.bottom,10)
            .pickerStyle(.segmented)
            if $viewModel.products.isEmpty {
                ProgressView()
                    .frame(width: 200,height: 200)
                Spacer()
            }else{
                ProductsGridView(path:$path, products: $viewModel.products.wrappedValue)
            }
        }
        .overlay(
            FloatingButtonView(isMenuExpanded: $isMenuExpanded, viewModel: viewModel)
        )
        .padding()
        
    }
}

#Preview {
  //  CategoriesView(path: .constant(NavigationPath()))
}

