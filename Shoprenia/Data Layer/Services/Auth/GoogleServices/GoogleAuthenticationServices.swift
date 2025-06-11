import Foundation
import GoogleSignIn
import FirebaseAuth
import FirebaseCore


final class GoogleAuthenticationServices : GoogleAuthenticationServicesProtocol {
    static let shared = GoogleAuthenticationServices()
    
    private init() {}
    
    
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void) {
        
        guard let clientID = FirebaseApp.app()?.options.clientID else { return }
        
    
        let config = GIDConfiguration(clientID: clientID)
        GIDSignIn.sharedInstance.configuration = config
        
    
        GIDSignIn.sharedInstance.signIn(withPresenting: rootController) {result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let user = result?.user,
                  let idToken = user.idToken?.tokenString
            else {
                print("Problem signing in with google")
                return
            }
            
            completion(.success(user))
            let credential = GoogleAuthProvider.credential(withIDToken: idToken,
                                                           accessToken: user.accessToken.tokenString)
        }
    }
}
