import Foundation
import MobileBuySDK
class UserDefaultsManager : UserDefaultsManagerProtocol {
    
    static let shared = UserDefaultsManager()
    
    private init(){}
    
    
    func insertShopifyCustomerId(_ customerId: String) {
        UserDefaults.standard.set(customerId, forKey: UserDefaultsKeys.shopifyCustomerId.rawValue)
    }
    
    func insertShopifyCustomerAccessToken(_ accessToken: String){
        UserDefaults.standard.set(accessToken, forKey: UserDefaultsKeys.shopifyCustomerAccessToken.rawValue)
    }
    
    func insertShopifyCustomerEmail(_ email: String){
        UserDefaults.standard.set(email, forKey: UserDefaultsKeys.shopifyCustomerEmail.rawValue)
    }
    
    func insertShopifyCustomerPhoneNumber(_ phoneNumber : String){
        UserDefaults.standard.set(phoneNumber, forKey: UserDefaultsKeys.shopifyCustomerPhoneNumber.rawValue)
    }
    
    func insertShopifyCustomerDisplayName(_ displayName : String){
        UserDefaults.standard.set(displayName, forKey: UserDefaultsKeys.shopifyCustomerDisplayName.rawValue)
    }
    
    func retrieveShopifyCustomerId() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.shopifyCustomerId.rawValue)
    }
    
    func retrieveShopifyCustomerAccessToken() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.shopifyCustomerAccessToken.rawValue)
    }
    
    func retrieveShopifyCustomerEmail() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.shopifyCustomerEmail.rawValue)
    }
    
    func retrieveShopifyCustomerPhoneNumber() -> String? {
        return UserDefaults.standard.string(forKey: UserDefaultsKeys.shopifyCustomerPhoneNumber.rawValue)
    }
    
    func retrieveShopifyCustomerDisplayName() -> String? {
        UserDefaults.standard.string(forKey: UserDefaultsKeys.shopifyCustomerDisplayName.rawValue)
    }
    
    func removeValueForKey(_ key:String){
        UserDefaults.standard.removeObject(forKey: key)
    }
    
}
