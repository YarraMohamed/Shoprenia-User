import SwiftUI
import FirebaseCore
import FirebaseAuth

@main
struct ShopreniaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            //RegisterationView()
            //LoginView()
            ProductDetailsView(productId: "gid://shopify/Product/7936016351306")
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate{
    
    func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()
    return true
  }
}
