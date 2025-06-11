//
//  SelectedAddressViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 11/06/2025.
//

import Foundation
import MobileBuySDK

class SelectedAddressViewModel : ObservableObject{
    
    private let cartUsecase: CartUsecaseProtocol
    
    init(cartUsecase: CartUsecaseProtocol) {
        self.cartUsecase = cartUsecase
    }
    
    func addAddressToCart(address: Storefront.MailingAddress ){
        cartUsecase.setAddressInCart(address: address) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(_):
                    print("added")
                case .failure(_):
                    print("not added")
                }
            }
          
        }
    }
    
}
