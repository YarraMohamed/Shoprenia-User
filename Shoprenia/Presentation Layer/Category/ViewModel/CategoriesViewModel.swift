//
//  CategoriesViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 03/06/2025.
//

import Foundation
import MobileBuySDK
import Combine

class CategoriesViewModel: ObservableObject {
    @Published var products: [Storefront.Product] = []
    @Published var selectedCategory: String = "Men"
    @Published var selectedSubCategory: String?
    
    private var cancellables: Set<AnyCancellable> = []
    private let fetchProductsUseCase: GetProducts
    
    init(fetchProductsUseCase: GetProducts) {
        self.fetchProductsUseCase = fetchProductsUseCase
        startObserving()
    }
    
    private func startObserving() {
        $selectedCategory
            .combineLatest($selectedSubCategory)
            .removeDuplicates { lhs, rhs in
                lhs.0 == rhs.0 && lhs.1 == rhs.1
            }
            .sink { [weak self] category, subCategory in
                self?.loadProducts(vendor: category, category: subCategory)
            }
            .store(in: &cancellables)
    }
    
    func loadProducts(vendor: String, category: String?) {
        //        fetchProductsUseCase.getFetchedProducts { [weak self] result in
        //            DispatchQueue.main.async {
        //                switch result {
        //                case .success(let products) :
        //                    if let category = category{
        //                        self?.products = products.filter{ $0.productType == category}
        //                    }else{
        //                        self?.products = products.filter { $0.vendor == vendor.uppercased()}
        //                    }
        //                case .failure(let error) :
        //                    print("Failed to load products: \(error.localizedDescription)")
        //                }
        //            }
        //        }
        fetchProductsUseCase.getFetchedProducts(vendor: vendor.uppercased()) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let products):
                    if let category = category {
                        self?.products = products.filter { $0.productType == category }
                    } else {
                        self?.products = products
                    }
                case .failure(let error):
                    print("Failed to load products: \(error.localizedDescription)")
                }
            }
            //        }
        }
    }
}
