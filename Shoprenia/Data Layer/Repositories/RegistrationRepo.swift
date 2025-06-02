import Foundation
import MobileBuySDK
import GoogleSignIn

final class RegistrationRepo : RegistrationRepoProtocol{
   
    static let shared = RegistrationRepo()
    private let remoteSource : RemoteDataSourceProtocol
    
    private init(remoteSource : RemoteDataSourceProtocol = RemoteDataSource.shared) {
        self.remoteSource = remoteSource
    }
    
    func createCustomer(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        phone : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void) {
        
        remoteSource.createCustomer(email: email,
                                    password: password,
                                    firstName: firstName,
                                    lastName: lastName,
                                    phone: phone,
                                    completion: completion)
        
    }
    
    func createFirebaseUser(email : String,
                            password : String,
                            firstname:String,
                            lastname : String,
                            completion:@escaping (Bool) -> Void) {
        
        remoteSource.createFirebaseUser(email: email,
                                        password: password,
                                        firstname: firstname,
                                        lastname: lastname,
                                        completion: completion)
        
    }
    
    func createCustomerWithoutPhone(email: String, password: String = "Password123", firstName: String, lastName: String, completion: @escaping (Result<MobileBuySDK.Storefront.Customer, any Error>) -> Void) {
        remoteSource.createCustomerWithoutPhone(email: email, password: password, firstName: firstName, lastName: lastName, completion: completion)
    }
    
    func createCustomerAccessToken(email: String, password: String, completionhandler: @escaping (Result<String, any Error>) -> Void) {
        remoteSource.createCustomerAccessToken(email: email, password: password, completionhandler: completionhandler)
    }
    
    func getCustomerByAccessToken(accessToken: String, completionHandler: @escaping (Result<MobileBuySDK.Storefront.Customer, any Error>) -> Void) {
        remoteSource.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completionHandler)
    }
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void){
        remoteSource.googleSignIn(rootController: rootController, completion: completion)
    }
    
}
