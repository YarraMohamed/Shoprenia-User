import Foundation


class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    private var credentialValidator : CredentialsValidationProtocol
    private var graphQLService : GraphQLServicesProtocol
    private var authenticationManager : AuthenticationManagerProtocol
    
    init(credentialValidator : CredentialsValidationProtocol = CredentialsValidation(),
         graphQLService : GraphQLServicesProtocol = GraphQLServices.shared,
         authenticationManager : AuthenticationManagerProtocol = FirebaseAuthenticationManager.shared) {
        self.credentialValidator = credentialValidator
        self.graphQLService = graphQLService
        self.authenticationManager = authenticationManager
    }
    
    func isValidEmail() -> Bool{
        return credentialValidator.isValidEmail(email: email)
    }
    
    func isValidPassword() -> Bool{
        return credentialValidator.isValidPassword(password: password)
    }
    
    func createCustomerAccessToken(){
        graphQLService.createCustomerAccessToken(email: email, password: password){[weak self] result in
            switch result {
            case .success(let accessToken):
                print("In Login ViewModel Access Token created: \(accessToken)")
                self?.getCustomerByAccessToken(accessToken: accessToken)
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func getCustomerByAccessToken(accessToken : String){
        graphQLService.getCustomerByAccessToken(accessToken: accessToken){ result in
            switch result {
            case .success(let customer):
                print("In Login ViewModel Customer fetched with id: \(customer.id)")
                print("In Login ViewModel Customer fetched with email: \(customer.email ?? "no mail")")
                print("In Login ViewModel Customer fetched with email: \(customer.phone ?? "no mail")")
                
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func logCustomerIn(){
        authenticationManager.signInUser(email: email, password: password)
    }
}
