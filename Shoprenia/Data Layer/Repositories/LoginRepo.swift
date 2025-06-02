import Foundation
import MobileBuySDK

final class LoginRepo : LoginRepoProtocol{
    static let shared = LoginRepo()
    private let remoteQLSource : RemoteDataSourceProtocol
    private let remoteFirebaseSource : FirebaseManagerProtocol
    
    private init(remoteSource : RemoteDataSourceProtocol = RemoteDataSource.shared){
        self.remoteQLSource = remoteSource
        self.remoteFirebaseSource = FirebaseAuthenticationManager.shared
    }
    
    func createCustomerAccessToken(email : String ,
                                   password : String ,
                                   completionhandler : @escaping (Result<String, Error>) -> Void){
        remoteQLSource.createCustomerAccessToken(email: email, password: password, completionhandler: completionhandler)
    }
    
    func getCustomerByAccessToken(accessToken:String,
                                  completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void){
        remoteQLSource.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completionHandler)
    }
    
    func signInFirebaseUser(email : String, password : String){
        remoteFirebaseSource.signInFirebaseUser(email: email, password: password)
    }
}
