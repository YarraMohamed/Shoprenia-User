import Foundation


enum UserDefaultsKeys: String {
    case shopifyCustomerId = "shopifyCustomerId"
    case shopifyCustomerAccessToken = "shopifyCustomerAccessToken"
    case shopifyCustomerEmail = "shopifyCustomerEmail"
    case shopifyCustomerPhoneNumber = "shopifyCustomerPhoneNumber"
    case shopifyCustomerDisplayName = "shopifyCustomerDisplayName"
    case shopifyCustomerCartId = "userCartId"
    
    
    
    
    static func get(_ key: UserDefaultsKeys) -> String? {
           UserDefaults.standard.string(forKey: key.rawValue)
       }
       
    static func set(_ value: String, for key: UserDefaultsKeys) {
           UserDefaults.standard.set(value, forKey: key.rawValue)
       }
       
    static func clear(_ key: UserDefaultsKeys) {
           UserDefaults.standard.removeObject(forKey: key.rawValue)
       }
}
