import SwiftUI

@main
struct ShopreniaApp: App {
    
    init(){
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.app]
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
