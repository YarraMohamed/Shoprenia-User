import Foundation


final class RegistarationViewModel : ObservableObject {
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var phoneNumber = ""
    @Published var firstNameEdited = false
    @Published var lastNameEdited = false
    @Published var emailEdited = false
    @Published var passwordEdited = false
    @Published var phoneEdited = false
    @Published var showVerificationAlert = false
    
    private var authManager : AuthenticationManagerProtocol
    private var graphQL : GraphQLServicesProtocol
    private var credentialValidator : CredentialsValidationProtocol
    
    init(authManager : AuthenticationManagerProtocol = FirebaseAuthenticationManager.shared,
         graphQL : GraphQLServicesProtocol = GraphQLServices.shared,
         credentialValidator : CredentialsValidationProtocol = CredentialsValidation()){
        self.authManager = authManager
        self.graphQL = graphQL
        self.credentialValidator = credentialValidator
    }
    
    func isValidName(_ name : String) -> Bool {
        credentialValidator.isValidName(name)
    }
    
    func isValidEmail() -> Bool {
        credentialValidator.isValidEmail(email: self.email)
    }
    
    func isValidPassword() -> Bool {
       
        credentialValidator.isValidPassword(password: self.password)
    }
    
    func isValidPhoneNumber() -> Bool {
        credentialValidator.isValidPhoneNumber(phoneNumber: self.phoneNumber)
    }
    
    func allValidation() -> Bool {
        return credentialValidator.isValidEmail(email: self.email) && credentialValidator.isValidName(firstName) && credentialValidator.isValidName(lastName) && credentialValidator.isValidPassword(password: self.password) && credentialValidator.isValidPhoneNumber(phoneNumber: self.phoneNumber)
    }
    
    func createUser(){
        authManager.createUser(email: email, password: password, firstname: firstName, lastname: lastName){[weak self] showAlert in
            self?.showVerificationAlert = showAlert
        }
    }
    
    func signInUser(){
        authManager.signInUser(email: email, password: password)
    }
    
    func createShopifyCustomer(){
        
        graphQL.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phoneNumber){ result in
            
            switch result{
            case .success(let customer):
                print("in view model shopify customer successfully created")
                print("in view model customer created and returned with first name: \(customer.firstName ?? "No name")")
                print("in view model customer created and returned with last name: \(customer.lastName ?? "No name")")
                print("in view model customer created and returned with phone: \(customer.phone ?? "No phone")")
                print("in view model customer created and returned with customer created at: \(customer.createdAt)")
                print("in view model customer created and returned with id: \(customer.id)")
                print("in view model customer created and returned with email: \(customer.email ?? "No mail")")
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
}
