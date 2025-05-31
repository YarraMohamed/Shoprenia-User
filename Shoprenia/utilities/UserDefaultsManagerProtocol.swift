import Foundation

protocol UserDefaultsManagerProtocol{
    
    func insertShopifyCustomerId(_ customerId: String)
    
    func insertShopifyCustomerAccessToken(_ accessToken: String)
    
    func insertShopifyCustomerEmail(_ email: String)
    
    func insertShopifyCustomerPhoneNumber(_ phoneNumber : String)
    
    func insertShopifyCustomerDisplayName(_ displayName : String)
    
    func retrieveShopifyCustomerId() -> String?
    
    func retrieveShopifyCustomerAccessToken() -> String?
    
    func retrieveShopifyCustomerEmail() -> String?
    
    func retrieveShopifyCustomerPhoneNumber() -> String?
    
    func retrieveShopifyCustomerDisplayName() -> String?
    
    func removeValueForKey(_ key:String)
    
}
