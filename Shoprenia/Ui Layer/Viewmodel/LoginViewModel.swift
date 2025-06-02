import Foundation
import MobileBuySDK

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""

    private var credentialValidator : CredentialsValidationProtocol
    private var userDefaultsManager : UserDefaultsManagerProtocol
    private var loginRepo : LoginRepoProtocol
    init(credentialValidator : CredentialsValidationProtocol = CredentialsValidation(),
         loginRepo : LoginRepoProtocol = LoginRepo.shared,
         userDefaultsManager : UserDefaultsManagerProtocol = UserDefaultsManager.shared) {
       
        self.credentialValidator = credentialValidator
        self.userDefaultsManager = userDefaultsManager
        self.loginRepo = loginRepo
    }
    
    func isValidEmail() -> Bool{
        return credentialValidator.isValidEmail(email: email)
    }
    
    func isValidPassword() -> Bool{
        return credentialValidator.isValidPassword(password: password)
    }
    
    func createCustomerAccessToken(){
        loginRepo.createCustomerAccessToken(email: email, password: password){[weak self] result in
            
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

        loginRepo.getCustomerByAccessToken(accessToken: accessToken){[weak self]result in
            switch result {
            case .success(let customer):
                print("Fetched Customer")
                print("id: \(customer.id)")
                print("email: \(customer.email ?? "no mail")")
                print("phone: \(customer.phone ?? "no mail")")
                self?.insertInUserDefaults(accessToken, customer)
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func signFirebaseUserIn(){
        loginRepo.signInFirebaseUser(email: email, password: password)
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
