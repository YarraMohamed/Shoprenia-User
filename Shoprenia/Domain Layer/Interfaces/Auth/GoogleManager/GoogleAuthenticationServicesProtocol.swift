import Foundation
import GoogleSignIn

protocol GoogleAuthenticationServicesProtocol{
    
    func googleSignOut()
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void)

}
