import Foundation
import MobileBuySDK
import GoogleSignIn
import FirebaseAuth

final class LoginRepo : LoginRepoProtocol{
    
    private let firebaseService : FirebaseManagerProtocol
    private let googleService : GoogleAuthenticationServicesProtocol
    private let customerService : CustomerServicesProtocol
    
    init(firebaseService: FirebaseManagerProtocol, googleService: GoogleAuthenticationServicesProtocol, customerService: CustomerServicesProtocol) {
        self.firebaseService = firebaseService
        self.googleService = googleService
        self.customerService = customerService
    }
    
    func createCustomerWithoutPhone(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<MobileBuySDK.Storefront.Customer, any Error>) -> Void) {
        customerService.createCustomerWithoutPhone(email: email, password: password, firstName: firstName, lastName: lastName, completion: completion)
    }
    
    func createCustomerAccessToken(email: String, password: String, completionhandler: @escaping (Result<String, any Error>) -> Void) {
        customerService.createCustomerAccessToken(email: email, password: password, completionhandler: completionhandler)
    }
    
    func getCustomerByAccessToken(accessToken: String, completionHandler: @escaping (Result<MobileBuySDK.Storefront.Customer, any Error>) -> Void) {
        customerService.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completionHandler)
    }
    
    func signInFirebaseUser(email: String, password: String) {
        firebaseService.signInFirebaseUser(email: email, password: password)
    }
    
    func googleSignIn(rootController: UIViewController, completion: @escaping (Result<User, any Error>) -> Void){
        googleService.googleSignIn(rootController: rootController, completion: completion)
    }
    
}
