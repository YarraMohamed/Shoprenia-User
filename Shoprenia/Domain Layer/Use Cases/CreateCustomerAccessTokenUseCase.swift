import Foundation


final class CreateCustomerAccessTokenUseCase{
    private let loginRepo : LoginRepoProtocol
    
    init(loginRepo: LoginRepoProtocol = LoginRepo.shared) {
        self.loginRepo = loginRepo
    }
    
    func CreateCustomerAccessToken(email:String,
                                   password:String,
                                   completion: @escaping(Result <String,Error>) -> Void){
        loginRepo.createCustomerAccessToken(email: email, password: password, completionhandler: completion)
    }
}
