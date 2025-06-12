//
//  ProductsView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var viewModel: ProductsViewModel
    @Binding var path : NavigationPath
    var vendor : String?
    var body: some View {
        VStack{
            if viewModel.products.isEmpty{
                ProgressView()
                    .frame(height: 350)
            }else{
                Divider()
                 HStack{
                     Image(systemName: "magnifyingglass")
                         .foregroundColor(.gray)
                     TextField("Search...", text: $viewModel.searchText)
                         .textInputAutocapitalization(.never)
                 }
                 .padding(10)
                 .background(Color(.systemGray6))
                 .cornerRadius(8)
                 .padding(10)
                
                if viewModel.isFilterDismissed {
                    ProductsGridView(path: $path, products: viewModel.filteredProducts)
                }else{
                    ProductsGridView(path: $path, products: viewModel.searchedProducts)
                }
            }
        }
        .navigationTitle(vendor ?? "Products")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("", image: .filter) {
                    viewModel.showFilter = true
                }
            }
        }
        .sheet(isPresented: $viewModel.showFilter,onDismiss: {
            viewModel.filterProducts()
            viewModel.isFilterDismissed = true
        }){
            SliderView(sliderValue: $viewModel.sliderValue,isPresented: $viewModel.showFilter)
        }
            .onAppear{
                guard let vendor = vendor else {
                    viewModel.loadAllProducts()
                    return
                }
                viewModel.loadVendorProducts(vendor: vendor)
            }
    }

}

#Preview {
    ProductsView(viewModel: ProductsViewModel(fetchProductsUseCase: GetProducts(repository: ProductsRepository(productService: ProductService()))), path: .constant(NavigationPath()))
}

