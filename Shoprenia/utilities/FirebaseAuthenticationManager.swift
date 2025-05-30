import Foundation
//import FirebaseAuth

final class FirebaseAuthenticationManager : ObservableObject{
    
//    static let shared = FirebaseAuthenticationManager()
//    
//    private init () {}
//    
//    func createUser(email : String, password : String, name : String) {
//        
//        
//        
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            
//            if let error = error {
//                print("Error registering new user : \(error.localizedDescription)")
//                return
//            }
//            
//            let changeRequest = authResult?.user.createProfileChangeRequest()
//            changeRequest?.displayName = name
//            changeRequest?.commitChanges { error in
//                if let error = error {
//                    print("Error updating profile: \(error.localizedDescription)")
//                } else {
//                    print("User created with name: \(name)")
//                }
//            }
//        }
//    }
//    
//    
//    func signInUser(email : String, password : String){
//        
//        Auth.auth().signIn(withEmail: email, password: password) { [weak self] authResult, error in
//          guard let strongSelf = self else { return }
//          
//            print("\(authResult?.user.displayName ?? "John doe") signed in with id : \(authResult?.user.uid ?? "No id")")
//            
//        }
//    }
}

