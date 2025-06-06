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
                     TextField("Search", text: .constant(""))
                 }
                 .padding(10)
                 .background(Color(.systemGray6))
                 .cornerRadius(8)
                 .padding(10)
                ProductsGridView(path: $path, products: viewModel.products)
            }
        }
        .navigationTitle(vendor ?? "Products")
        .toolbar{
            ToolbarItem(placement: .topBarTrailing) {
                Button("", image: .filter) {
                    print("ok")
                }
            }
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

