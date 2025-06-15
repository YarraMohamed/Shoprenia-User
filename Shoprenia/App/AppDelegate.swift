import FirebaseFirestore
import SwiftUI
import FirebaseCore
import FirebaseAuth
import GoogleSignIn
import Stripe

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        let db = Firestore.firestore()
        StripeAPI.defaultPublishableKey = "pk_test_51Ra4beRuzZjExwGEMGXCln5nmowPLvWjnVtYhsswo6BTQkfD28Sznbat9E8SXvbdUg1rMWCywhnPLt6eWGrSZ4zh00zmtNwKFS"
    return true
  }
    
    func application(_ app: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
      return GIDSignIn.sharedInstance.handle(url)
    }
}
