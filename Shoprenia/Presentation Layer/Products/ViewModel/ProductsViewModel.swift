//
//  ProductsViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 31/05/2025.
//
import Combine
import Foundation
import MobileBuySDK

class ProductsViewModel : ObservableObject {
    private let fetchProductsUseCase: GetProducts
    private var cancellables = Set<AnyCancellable>()
    @Published var showFilter = false
    @Published var isFilterDismissed = false
    @Published var sliderValue : Double = 19.0
    @Published var searchText : String = ""
    @Published var searchedProducts : [Storefront.Product] = []
    @Published var filteredProducts : [Storefront.Product] = []
    @Published var products: [Storefront.Product] = []
    
    init(fetchProductsUseCase: GetProducts) {
        self.fetchProductsUseCase = fetchProductsUseCase
        
       setupProducSearch()
        
    }
    
    private func setupProducSearch() {
        $searchText
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] searchTerm in
                guard let self = self else { return }

                if searchTerm.isEmpty {
                    self.searchedProducts = self.products
                } else {
                    isFilterDismissed = false
                    self.searchedProducts = self.products.filter {
                        $0.title.lowercased().contains(self.searchText)
                    }
                }
            }
            .store(in: &cancellables)
    }
    
    func filterProducts() {
            filteredProducts = products.filter { product in
                product.variants.nodes.contains { variant in
                    let sliderDecimal = Decimal(sliderValue)
                   return variant.price.amount >= sliderDecimal
                }
            }
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
