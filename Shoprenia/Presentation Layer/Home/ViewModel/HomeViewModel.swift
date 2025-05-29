//
//  HomeViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 29/05/2025.
//

import Foundation
import MobileBuySDK

class HomeViewModel: ObservableObject {
    private let fetchBrandsUseCase: GetVendors
    
    @Published var brands: [Storefront.Collection] = []
    
    init(fetchBrandsUseCase: GetVendors) {
        self.fetchBrandsUseCase = fetchBrandsUseCase
    }
    
    func loadBrands() {
        fetchBrandsUseCase.getFetchedVendors{ [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let vendors):
                    self?.brands = Array(vendors.dropFirst())
                case .failure(let error):
                    print("Error: \(error.localizedDescription)")
                }
            }
        }
    }
}
