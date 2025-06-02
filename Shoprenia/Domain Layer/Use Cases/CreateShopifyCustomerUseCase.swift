import Foundation
import MobileBuySDK

final class CreateShopifyCustomerUseCase{
    private let registrationRepo : RegistrationRepoProtocol
    
    init(registrationRepo: RegistrationRepoProtocol = RegistrationRepo.shared) {
        self.registrationRepo = registrationRepo
    }
    
    func createShopifyCustomer(email : String ,
                               password : String ,
                               firstName : String,
                               lastName : String,
                               phone : String,
                               completion: @escaping (Result<Storefront.Customer,Error>) -> Void){
        registrationRepo.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone, completion: completion)
    }
}
