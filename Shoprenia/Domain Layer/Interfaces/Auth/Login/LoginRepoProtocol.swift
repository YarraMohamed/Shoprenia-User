import Foundation
import MobileBuySDK
import GoogleSignIn
import FirebaseAuth
protocol LoginRepoProtocol{
    
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
    
    func signInFirebaseUser(email : String, password : String)
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<User, Error>)->Void)
}
