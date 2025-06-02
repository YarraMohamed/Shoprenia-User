import Foundation
import MobileBuySDK
import GoogleSignIn

final class LoginRepo : LoginRepoProtocol{
    static let shared = LoginRepo()
    private let remoteSource : RemoteDataSourceProtocol
    
    private init(remoteSource : RemoteDataSourceProtocol = RemoteDataSource.shared){
        self.remoteSource  = remoteSource
    }
    
    func createCustomerWithoutPhone(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<Storefront.Customer, any Error>) -> Void) {
        remoteSource.createCustomerWithoutPhone(email: email, password: password, firstName: firstName, lastName: lastName, completion: completion)
    }
    
    func createCustomerAccessToken(email : String ,
                                   password : String ,
                                   completionhandler : @escaping (Result<String, Error>) -> Void){
        remoteSource.createCustomerAccessToken(email: email, password: password, completionhandler: completionhandler)
    }
    
    
    
    func getCustomerByAccessToken(accessToken:String,
                                  completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void){
        remoteSource.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completionHandler)
    }
    
    func signInFirebaseUser(email : String, password : String){
        remoteSource.signInFirebaseUser(email: email, password: password)
    }
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void) {
        remoteSource.googleSignIn(rootController: rootController, completion: completion)
    }
}
