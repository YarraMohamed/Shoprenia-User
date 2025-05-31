import Foundation


protocol AuthenticationManagerProtocol {
    var showVerificationAlert : Bool {get set}
    func createUser(email : String, password : String, firstname:String, lastname : String,completion:@escaping (Bool) -> Void)
    func signInUser(email : String, password : String)
    
}
