import Foundation
import GoogleSignIn
import MobileBuySDK
import FirebaseAuth

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
    @Published var isAccountCreated : Bool = false
    @Published var showRegisteredAlert = false
    
    private let registrationRepo : RegistrationRepoProtocol
    private let credentialValidator : CredentialsValidationProtocol
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    init(credentialValidator : CredentialsValidationProtocol,
         registraionRepo : RegistrationRepoProtocol,
         userDefaultsManager : UserDefaultsManagerProtocol){
        
        self.credentialValidator = credentialValidator
        self.registrationRepo = registraionRepo
        self.userDefaultsManager = userDefaultsManager
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
        registrationRepo.createFirebaseUser(email: email, password: password, firstname: firstName, lastname: lastName){[weak self] showAlert in
            
            switch showAlert{
            case true:
                self?.showVerificationAlert = true
                self?.createShopifyCustomer()
            case false:
                self?.showRegisteredAlert = true
            }
        }
    }
    
    func createShopifyCustomer(){
        
        registrationRepo.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phoneNumber){ result in
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
    
    
    func googleSignIn(rootController : UIViewController) {
       
        registrationRepo.googleSignIn(rootController: rootController){ result in
            
            switch result {
            case .success(let googleUser):
                self.createShopifyCustomerWithoutPhone(user: googleUser)
            case .failure(let error):
                print("ERR in g sign in \(error.localizedDescription)")
            }
        }
    }
    
    func createShopifyCustomerWithoutPhone(user:User){
        registrationRepo.createCustomerWithoutPhone(email: user.email ?? "No mail",
                                             password: "Password123",
                                                    firstName: user.displayName ?? "no first name",
                                                    lastName: ""){[weak self] result in
            
            switch result {
            case .success(let customer):
                
                print("In Regist ViewModel shopify customer created using google with name : \(customer.displayName)")
                print("In Regist ViewModel shopify customer created using google with email : \(customer.email ?? "no mail")")
                self?.isAccountCreated = true
            case .failure(let error):
                print("In regist Viewmodel Error: \(error)")
            }
        }
    }
}
