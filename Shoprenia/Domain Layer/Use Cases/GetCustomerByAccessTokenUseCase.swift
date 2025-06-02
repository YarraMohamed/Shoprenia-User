import Foundation
import MobileBuySDK

class GetCustomerByAccessTokenUseCase{
    private let loginRepo:LoginRepoProtocol
    
    init(loginRepo: LoginRepoProtocol = LoginRepo.shared) {
        self.loginRepo = loginRepo
    }
    
    func getCustomerByAccessToken(_ accessToken : String,
                                  completion:@escaping (Result<Storefront.Customer,Error>) -> Void){
        loginRepo.getCustomerByAccessToken(accessToken: accessToken, completionHandler: completion)
    }
}
