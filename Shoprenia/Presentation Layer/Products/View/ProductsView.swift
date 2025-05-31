//
//  ProductsView.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 30/05/2025.
//

import SwiftUI

struct ProductsView: View {
    @StateObject private var viewModel: ProductsViewModel = ProductsViewModel(fetchProductsUseCase: GetProducts(repository: ProductsRepository(productService: ProductService())))
    var vendor : String?
    var body: some View {
        VStack{
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
            if viewModel.products.isEmpty{
                ProgressView()
                    .frame(height: 350)
            }else{
                ProductsGridView(products: viewModel.products)
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
    ProductsView()
}

