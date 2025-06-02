import Foundation


final class CreateFirebaseUserUseCase{
    private let registerationRepo : RegistrationRepoProtocol
    
    init(registerationRepo: RegistrationRepoProtocol = RegistrationRepo.shared) {
        self.registerationRepo = registerationRepo
    }
    
    func createFirebaseUser(email: String,
                             password: String,
                             firstname: String,
                             lastname: String,
                            completion:@escaping (Bool) -> Void){
        
        registerationRepo.createFirebaseUser(email: email,
                                             password: password,
                                             firstname: firstname,
                                             lastname: lastname,
                                             completion: completion)
        
    }
    
}
