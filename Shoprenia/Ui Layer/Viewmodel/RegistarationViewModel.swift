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
    
    private let shopifyUserCase : CreateShopifyCustomerUseCase
    private let firebaseUserCase : CreateFirebaseUserUseCase
    private var credentialValidator : CredentialsValidationProtocol
    
    init(createShopifyCustomer : CreateShopifyCustomerUseCase = CreateShopifyCustomerUseCase(),
         createFirebaseUser : CreateFirebaseUserUseCase = CreateFirebaseUserUseCase(),
         credentialValidator : CredentialsValidationProtocol = CredentialsValidation()){
    
        self.credentialValidator = credentialValidator
        self.shopifyUserCase = createShopifyCustomer
        self.firebaseUserCase = createFirebaseUser
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
        firebaseUserCase.createFirebaseUser(email: email, password: password, firstname: firstName, lastname: lastName){[weak self] showAlert in
            self?.showVerificationAlert = showAlert
        }
    }
    
    func createShopifyCustomer(){
        
        shopifyUserCase.createShopifyCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phoneNumber){ result in
            switch result{
            case .success(let customer):
                print("shopify customer created")
                print("first name: \(customer.firstName ?? "No name")")
                print("last name: \(customer.lastName ?? "No name")")
                print("phone: \(customer.phone ?? "No phone")")
                print("created at: \(customer.createdAt)")
                print("id: \(customer.id)")
                print("email: \(customer.email ?? "No mail")")
                
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
}
