//
//  OrderHistoryViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 12/06/2025.
//

import Foundation
import MobileBuySDK

class OrderHistoryViewModel : ObservableObject{
    @Published var orders : [Storefront.Order] = []
    private let usecase : OrderHistoryUsecaseProtocol
    
    init(usecase: OrderHistoryUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func getOrderHistory(accessToken : String){
        usecase.getOrderHistory(accessToken: accessToken) { [weak self] result in
            DispatchQueue.main.async {
                switch result{
                case .success(let orders):
                    self?.orders  = orders
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        
    }
}
