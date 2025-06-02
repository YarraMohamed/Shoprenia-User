import Foundation
import MobileBuySDK

protocol LoginRepoProtocol{
    func createCustomerAccessToken(email : String ,
                                   password : String ,
                                   completionhandler : @escaping (Result<String, Error>) -> Void)
    
    func getCustomerByAccessToken(accessToken:String,
                                  completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void)
    
    func signInFirebaseUser(email : String, password : String)
}
