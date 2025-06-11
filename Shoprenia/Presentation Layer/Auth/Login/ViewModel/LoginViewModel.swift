import Foundation
import MobileBuySDK
import GoogleSignIn

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn : Bool = false
   
    private var credentialValidator : CredentialsValidationProtocol
    private var userDefaultsManager : UserDefaultsManagerProtocol
    private var loginRepo : LoginRepoProtocol
    
    init(credentialValidator: CredentialsValidationProtocol, userDefaultsManager: UserDefaultsManagerProtocol, loginRepo: LoginRepoProtocol) {
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
    
    func googleSignIn(rootController : UIViewController) {
       
        loginRepo.googleSignIn(rootController: rootController){ result in
            
            switch result {
            case .success(let googleUser):
                self.createCustomerWithoutPhone(user: googleUser)
                self.isLoggedIn = true
            case .failure(let error):
                print("ERR in g sign in \(error.localizedDescription)")
            }
        }
    }
    
    func createCustomerWithoutPhone(user:GIDGoogleUser){
        loginRepo.createCustomerWithoutPhone(email: user.profile?.email ?? "No mail",
                                             password: "Password123",
                                             firstName: user.profile?.givenName ?? "no first name",
                                             lastName: user.profile?.familyName ?? "no last name"){result in
            
            switch result {
            case .success(let customer):
                print("In Login ViewModel shopify customer created using google with name : \(customer.displayName)")
                print("In Login ViewModel shopify customer created using google with email : \(customer.email ?? "no mail")")
                self.createCustomerAccessToken(mail: customer.email ?? "no mail", pass: "Password123")
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
            
        }
    }
    
    func createCustomerAccessToken(mail:String, pass:String){
        loginRepo.createCustomerAccessToken(email: mail, password: pass){[weak self] result in
            
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
                print("phone: \(customer.phone ?? "no phone")")
                self?.insertInUserDefaultsWithoutPhone(accessToken, customer)
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func signFirebaseUserIn(){
        self.isLoggedIn = true
        loginRepo.signInFirebaseUser(email: email, password: password)
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
