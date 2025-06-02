import Foundation
import GoogleSignIn
import MobileBuySDK

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
    
    private let registrationRepo : RegistrationRepoProtocol
    private let credentialValidator : CredentialsValidationProtocol
    private let userDefaultsManager : UserDefaultsManagerProtocol
    
    init(createShopifyCustomer : CreateShopifyCustomerUseCase = CreateShopifyCustomerUseCase(),
         createFirebaseUser : CreateFirebaseUserUseCase = CreateFirebaseUserUseCase(),
         credentialValidator : CredentialsValidationProtocol = CredentialsValidation(),
         registraionRepo : RegistrationRepoProtocol = RegistrationRepo.shared,
         userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultsManager.shared){
        
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
            self?.showVerificationAlert = showAlert
            self?.createShopifyCustomer()
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
                print("Created google user with : \(googleUser.profile?.name ?? "No name")")
                self.createShopifyCustomerWithoutPhone(user: googleUser)
            case .failure(let error):
                print("ERR in g sign in \(error.localizedDescription)")
            }
        }
    }
    
    func createShopifyCustomerWithoutPhone(user:GIDGoogleUser){
        registrationRepo.createCustomerWithoutPhone(email: user.profile?.email ?? "No mail",
                                             password: "Password123",
                                             firstName: user.profile?.givenName ?? "no first name",
                                             lastName: user.profile?.familyName ?? "no last name"){result in
            
            switch result {
            case .success(let customer):
                
                print("In Regist ViewModel shopify customer created using google with name : \(customer.displayName)")
                print("In Regist ViewModel shopify customer created using google with email : \(customer.email ?? "no mail")")
                
                self.createCustomerAccessToken(mail: customer.email ?? "no mail", pass: "Password123")
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func createCustomerAccessToken(mail:String, pass:String){
        registrationRepo.createCustomerAccessToken(email: mail, password: pass){[weak self] result in
            
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

        registrationRepo.getCustomerByAccessToken(accessToken: accessToken){[weak self]result in
            switch result {
                
            case .success(let customer):
                print("Fetched Customer")
                print("id: \(customer.id)")
                print("email: \(customer.email ?? "no mail")")
                print("phone: \(customer.phone ?? "no phone")")
                
                self?.insertInUserDefaultsWithoutPhone(accessToken, customer)
                
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func insertInUserDefaultsWithoutPhone(_ accessToken : String,_ customer : Storefront.Customer){
        guard let email = customer.email else {return}
        userDefaultsManager.insertShopifyCustomerId(customer.id.rawValue)
        userDefaultsManager.insertShopifyCustomerEmail(email)
        userDefaultsManager.insertShopifyCustomerAccessToken(accessToken)
        userDefaultsManager.insertShopifyCustomerDisplayName(customer.displayName)
    }
    
    func insertInUserDefaults(_ accessToken : String,_ customer : Storefront.Customer){
        guard let email = customer.email else {return}
        guard let phone = customer.phone else {return}
        userDefaultsManager.insertShopifyCustomerId(customer.id.rawValue)
        userDefaultsManager.insertShopifyCustomerEmail(email)
        userDefaultsManager.insertShopifyCustomerPhoneNumber(phone)
        userDefaultsManager.insertShopifyCustomerAccessToken(accessToken)
        userDefaultsManager.insertShopifyCustomerDisplayName(customer.displayName)
    }
}
