//
//  AuthenticationViewModel.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 06/06/2025.
//

import Foundation

class AuthenticationViewModel : ObservableObject{
    @Published var isAuth : Bool = false
    
    private var userDefaults : UserDefaultsManagerProtocol
    
    init(userDefaults: UserDefaultsManagerProtocol) {
        self.userDefaults = userDefaults
    }
    
    func getAccessToken() -> String?{
        return userDefaults.retrieveShopifyCustomerAccessToken()
    }
    
    func isAuthenticated() {
        print("isAuth \(isAuth)")
        isAuth = getAccessToken() !=  nil
    }
}
