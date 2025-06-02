import Foundation
import MobileBuySDK
import GoogleSignIn
final class RemoteDataSource : RemoteDataSourceProtocol {
    
    static let shared = RemoteDataSource()
    
    private let graphQLService : GraphQLServicesProtocol
    private let firebaseService : FirebaseManagerProtocol
    private let googleService : GoogleAuthenticationServicesProtocol
   
    private init(graphQLService : GraphQLServicesProtocol = GraphQLServices.shared,
                 firebaseService : FirebaseManagerProtocol = FirebaseAuthenticationManager.shared,
                 googleService : GoogleAuthenticationServicesProtocol = GoogleAuthenticationServices.shared) {
        
        self.graphQLService = graphQLService
        self.firebaseService = firebaseService
        self.googleService = googleService
    }
    
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void){
            graphQLService.fetchProductDetails(id: id, completion: completion)
    }
    
    
    func createCustomer(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        phone : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void){

        graphQLService.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone, completion: completion)
    }
    
    func createCustomerWithoutPhone(email: String, password: String, firstName: String, lastName: String, completion: @escaping (Result<Storefront.Customer, any Error>) -> Void) {
        graphQLService.createCustomerWithoutPhone(email: email, password: password, firstName: firstName, lastName: lastName, completion: completion)
    }
    
    
    func createCustomerAccessToken(email : String , password : String , completionhandler : @escaping (Result<String, Error>) -> Void){
        
        graphQLService.createCustomerAccessToken(email: email, password: password, completionhandler: completionhandler)
    }
    
    
    func getCustomerByAccessToken(accessToken:String,completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void){
        graphQLService.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completionHandler)
    }
    
    func createFirebaseUser(email: String, password: String, firstname: String, lastname: String, completion: @escaping (Bool) -> Void) {
        firebaseService.createFirebaseUser(email: email, password: password, firstname: firstname, lastname: lastname, completion: completion)
    }
    
    func signInFirebaseUser(email: String, password: String) {
        firebaseService.signInFirebaseUser(email: email, password: password)
    }
    
    func googleSignOut() {
        googleService.googleSignOut()
    }
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void) {
        googleService.googleSignIn(rootController: rootController, completion: completion)
    }
    
}
