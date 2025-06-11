import Foundation
import GoogleSignIn

protocol GoogleAuthenticationServicesProtocol{
    func googleSignIn(rootController : UIViewController,completion: @escaping(Result<GIDGoogleUser, Error>)->Void)
}
