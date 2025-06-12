import Foundation

final class LogoutFromGoogle : LogoutFromGoogleUseCaseProtocol {

    private let repository: AddressRepositoryProtocol

    init(repository: AddressRepositoryProtocol) {
        self.repository = repository
    }

    func execute(){
        repository.signOutFirebaseUser()
    }
    
}
