import Foundation
import MobileBuySDK

protocol RegistrationRepoProtocol{
    
    func createCustomer(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        phone : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void)
    
    func createFirebaseUser(email : String,
                            password : String,
                            firstname:String,
                            lastname : String,
                            completion:@escaping (Bool) -> Void)
    
}
