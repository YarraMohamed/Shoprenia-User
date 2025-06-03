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
    
    private var cancellables: Set<AnyCancellable> = []
    private let fetchProductsUseCase: GetProducts
    
    init(fetchProductsUseCase: GetProducts) {
        self.fetchProductsUseCase = fetchProductsUseCase
        startObserving()
    }
    
    
    private func startObserving() {
        $selectedCategory
            .removeDuplicates()
            .sink { [weak self] category in
                self?.loadProducts(vendor: category.uppercased())
            }.store(in: &cancellables)
    }
    
    func loadProducts(vendor: String) {
        fetchProductsUseCase.getFetchedProducts(vendor: vendor.uppercased()) { [weak self] result in
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
