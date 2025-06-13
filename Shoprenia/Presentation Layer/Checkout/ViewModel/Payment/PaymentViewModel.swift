//
//  PaymentViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 13/06/2025.
//

import Foundation

class PaymentViewModel : ObservableObject{
    @Published var isSuccess:Bool = false
    
    let usecase : PaymentUsecaseProtocol
    init(usecase: PaymentUsecaseProtocol) {
        self.usecase = usecase
    }
    
    func confirmOrder(){
        usecase.placeOrder { [weak self] result in
            switch result{
            case .success(_) :
                self?.isSuccess = true
            case .failure(_) :
                self?.isSuccess = false
            }
        }
    }
    
}
