import Foundation
import MobileBuySDK

protocol CustomerServicesProtocol {
    
   
    func createCustomerAccessToken(email : String , password : String , completionhandler : @escaping (Result<String, Error>) -> Void)
    func getCustomerByAccessToken(accessToken:String,completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void)
    func createCustomer(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        phone : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void)
    
    func createCustomerWithoutPhone(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void)
    
}
