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
    
    init(authManager : AuthenticationManagerProtocol = FirebaseAuthenticationManager.shared, graphQL : GraphQLServicesProtocol = GraphQLServices.shared){
        self.authManager = authManager
        self.graphQL = graphQL
    }
    
    func isValidName(_ name : String) -> Bool {
        return name.count > 3
    }
    
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
            let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: self.email)
    }
    
    func isValidPassword() -> Bool {
        return self.password.count > 7
    }
    
    func isValidPhoneNumber() -> Bool {
        return self.phoneNumber.count == 11
    }
    
    func allValidation() -> Bool {
        return isValidEmail() && isValidName(firstName) && isValidName(lastName) && isValidPassword() && isValidPhoneNumber()
    }
    
    func createUser(email : String, password : String, name : String){
        authManager.createUser(email: email, password: password, name: name){[weak self] showAlert in
            self?.showVerificationAlert = showAlert
        }
    }
    
    func signInUser(email : String, password : String){
        authManager.signInUser(email: email, password: password)
    }
    
    func createShopifyCustomer(email : String ,
                               password : String ,
                               firstName : String,
                               lastName : String,
                               phone : String){
        
        graphQL.createCustomer(email: email, password: password, firstName: firstName, lastName: lastName, phone: phone){ result in
            
            switch result{
            case .success(let customer):
                print("in view model \(customer.email ?? "No mail")")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
        
    }
    
}
