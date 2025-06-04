
import SwiftUI

@main
struct ShopreniaApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.app]
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

