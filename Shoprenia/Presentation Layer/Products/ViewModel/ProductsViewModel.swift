//
//  ProductsViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//

import Foundation
import MobileBuySDK

class ProductsViewModel : ObservableObject {
    private let fetchProductsUseCase: GetProducts
    
    @Published var products: [Storefront.Product] = []
    
    init(fetchProductsUseCase: GetProducts) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func loadAllProducts() {
        fetchProductsUseCase.getFetchedProducts { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let products):
                    self?.products = products
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    func loadVendorProducts(vendor: String) {
//        fetchProductsUseCase.getFetchedProducts { [weak self] result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let products):
//                    self?.products = products.filter { $0.vendor == vendor}
//                case .failure(let error) :
//                    print(error.localizedDescription)
//                }
//            }
//        }
        
        fetchProductsUseCase.getFetchedProducts(vendor: vendor) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let products):
                    self?.products = products
                case .failure(let error) :
                    print(error.localizedDescription)
                }
            }
        }
    }
}
