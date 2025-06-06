
import SwiftUI

@main
struct ShopreniaApp: App {
    @StateObject var vm : AuthenticationViewModel = AuthenticationViewModel(userDefaults: UserDefaultsManager.shared)
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.app]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}

