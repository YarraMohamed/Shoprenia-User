import Foundation


protocol AuthenticationManagerProtocol {
    var showVerificationAlert : Bool {get set}
    func createUser(email : String, password : String, name : String,completion:@escaping (Bool) -> Void)
    func signInUser(email : String, password : String)
    
}
