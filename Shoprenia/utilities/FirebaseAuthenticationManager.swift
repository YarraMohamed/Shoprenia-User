import Foundation
import FirebaseCore
import FirebaseAuth


final class FirebaseAuthenticationManager : AuthenticationManagerProtocol, ObservableObject{
    
    @Published var showVerificationAlert : Bool = false
    static let shared = FirebaseAuthenticationManager()
    
    private init () {}
    
    func createUser(email : String, password : String, name : String,completion:@escaping (Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            
            if let error = error {
                print("Error registering new user : \(error.localizedDescription)")
                return
            }
            
            
            let changeRequest = authResult?.user.createProfileChangeRequest()
            changeRequest?.displayName = name
            changeRequest?.commitChanges {error in
                if let error = error {
                    print("Error updating profile: \(error.localizedDescription)")
                } else {
                    print("User created with name: \(name)")
                }
            }
            
            
            authResult?.user.sendEmailVerification { error in
                    if let error = error {
                        print("Problem in email verification : \(error.localizedDescription)")
                    } else {
                        completion(true)
                    }
            }
        }
    }
    
    
    func signInUser(email : String, password : String){
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
          guard let strongSelf = self else { return }
          
            print("\(authResult?.user.displayName ?? "John doe") signed in with id : \(authResult?.user.uid ?? "No id")")
            
        }
    }
}

