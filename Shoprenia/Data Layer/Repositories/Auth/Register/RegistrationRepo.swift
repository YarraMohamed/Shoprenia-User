import Foundation
import MobileBuySDK
import GoogleSignIn

final class RegistrationRepo : RegistrationRepoProtocol{
    
    private let firebaseService : FirebaseManagerProtocol
    private let googleService : GoogleAuthenticationServicesProtocol
    private let customerService : CustomerServicesProtocol
    
    init(firebaseService: FirebaseManagerProtocol, googleService: GoogleAuthenticationServicesProtocol, customerService: CustomerServicesProtocol) {
        self.firebaseService = firebaseService
        self.googleService = googleService
        self.customerService = customerService
    }
    
    func createCustomer(email: String, password: String, firstName: String, lastName: String, phone: String, completion: @escaping (Result<MobileBuySDK.Storefront.Customer, any Error>) -> Void) {
        customerService.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone, completion: completion)
    }
    
    func createFirebaseUser(email: String, password: String, firstname: String, lastname: String, completion: @escaping (Bool) -> Void) {
        firebaseService.createFirebaseUser(email: email, password: password, firstname: firstname, lastname: lastname, completion: completion)
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
    
    func googleSignIn(rootController: UIViewController, completion: @escaping (Result<GIDGoogleUser, any Error>) -> Void){
        googleService.googleSignIn(rootController: rootController, completion: completion)
    }
}
