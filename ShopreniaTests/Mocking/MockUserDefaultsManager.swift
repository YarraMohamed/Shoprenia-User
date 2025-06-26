//
//  MockUserDefaultsManager.swift
//  ShopreniaTests
//
//  Created by Yara Mohamed on 26/06/2025.
//

import Foundation
@testable import Shoprenia

class MockUserDefaultsManager: UserDefaultsManagerProtocol {
   
    var accessToken: String? = nil
    var displayName: String? = nil
    
    func retrieveShopifyCustomerAccessToken() -> String? {
        return accessToken
    }
    
    func retrieveShopifyCustomerDisplayName() -> String? {
        return displayName
    }
    
    func insertShopifyCustomerId(_ customerId: String) {
        
    }
    
    func insertShopifyCustomerAccessToken(_ accessToken: String) {
        
    }
    
    func insertShopifyCustomerEmail(_ email: String) {
        
    }
    
    func insertShopifyCustomerPhoneNumber(_ phoneNumber: String) {
        
    }
    
    func insertShopifyCustomerDisplayName(_ displayName: String) {
        
    }
    
    func retrieveShopifyCustomerId() -> String? {
        return nil
    }
    
    func retrieveShopifyCustomerEmail() -> String? {
        return nil

    }
    
    func retrieveShopifyCustomerPhoneNumber() -> String? {
        return nil

    }
    
    func removeValueForKey(_ key: String) {
        
    }
}
