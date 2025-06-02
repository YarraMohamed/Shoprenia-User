import Foundation
import MobileBuySDK

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
    
}
