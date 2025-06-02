import Foundation


final class LogCustomerInUseCase{
    private let loginRepo : LoginRepoProtocol
    
    init(loginRepo: LoginRepoProtocol = LoginRepo.shared) {
        self.loginRepo = loginRepo
    }
    
    func signFirebaseUserIn(email:String, password:String){
        loginRepo.signInFirebaseUser(email: email, password: password)
    }
}
