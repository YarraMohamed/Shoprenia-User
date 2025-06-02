import Foundation
import MobileBuySDK
import GoogleSignIn

protocol RemoteDataSourceProtocol {
    
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void)
    
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
    
    func createCustomerAccessToken(email : String ,
                                   password : String ,
                                   completionhandler : @escaping (Result<String, Error>) -> Void)
    
    func getCustomerByAccessToken(accessToken:String,
                                  completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void)
    
    func createFirebaseUser(email : String, password : String, firstname:String, lastname : String,completion:@escaping (Bool) -> Void)
    
    func signInFirebaseUser(email : String, password : String)
    
    func googleSignOut()
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void) 
    
}
