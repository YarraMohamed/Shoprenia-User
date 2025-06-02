import Foundation


protocol FirebaseManagerProtocol {
    var showVerificationAlert : Bool {get set}
    func createFirebaseUser(email : String, password : String, firstname:String, lastname : String,completion:@escaping (Bool) -> Void)
    func signInFirebaseUser(email : String, password : String)
    
}
