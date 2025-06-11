import Foundation
import FirebaseAuth
import GoogleSignIn

protocol GoogleAuthenticationServicesProtocol{
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<User, Error>)->Void)
}
