import Foundation
import MobileBuySDK
import GoogleSignIn
import FirebaseAuth

class LoginViewModel: ObservableObject {
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var isLoggedIn : Bool = false
    @Published var showAlert: Bool = false
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
       
        loginRepo.googleSignIn(rootController: rootController){[weak self] result in
            
            switch result {
            case .success(let googleUser):
                guard let email = googleUser.email else { return }
                self?.createCustomerAccessToken(mail: email, pass: "Password123",signInMethod: "google")
            case .failure(let error):
                print("ERR in g sign in \(error.localizedDescription)")
            }
        }
    }
    
    func createCustomerAccessToken(mail:String,pass:String,signInMethod: String){
        loginRepo.createCustomerAccessToken(email: mail, password: pass){[weak self] result in
            
            switch result {
            case .success(let accessToken):
                print("In Login ViewModel Access Token created: \(accessToken)")
                self?.getCustomerByAccessToken(accessToken: accessToken,signInMethod: signInMethod)
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func getCustomerByAccessToken(accessToken : String,signInMethod: String){

        loginRepo.getCustomerByAccessToken(accessToken: accessToken){[weak self]result in
            switch result {
            case .success(let customer):
                print("Fetched Customer")
                print("id: \(customer.id)")
                print("email: \(customer.email ?? "no mail")")
                print("phone: \(customer.phone ?? "no phone")")
                self?.isLoggedIn = true
                switch signInMethod {
                case "google":
                    print("case google inserted in userdefaults without phone")
                    self?.insertInUserDefaultsWithoutPhone(accessToken, customer)
                case "regular":
                    print("case regular inserted in userdefaults with phone")
                    self?.insertInUserDefaults(accessToken, customer)
                default:
                    print("Nothing to do")
                }
                
            case .failure(let error):
                print("In Login Viewmodel Error: \(error)")
            }
        }
    }
    
    func signFirebaseUserIn(){
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
