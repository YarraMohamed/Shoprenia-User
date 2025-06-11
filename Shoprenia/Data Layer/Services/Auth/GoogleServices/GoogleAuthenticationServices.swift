import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore


final class GoogleAuthenticationServices : GoogleAuthenticationServicesProtocol {
    static let shared = GoogleAuthenticationServices()
    
    private init() {}
    
    
    func googleSignIn(rootController: UIViewController, completion: @escaping(Result<User, Error>) -> Void) {
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }

       
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config

        
        GIDSignIn.sharedInstance.signIn(withPresenting: rootController) {result, error in
          guard error == nil else {
            return
          }

          guard let user = result?.user,
            let idToken = user.idToken?.tokenString
          else {
            return
          }

          let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                         accessToken: user.accessToken.tokenString)
          
            Auth.auth().signIn(with: credential) { result, error in
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let result = result else {
                    return
                }
                print("retrieved g user with id : \(result.user.uid)")
                print("retrieved g user with name : \(result.user.displayName ?? "none")")
                completion(.success(result.user))
                
            }
        }
    }
}
