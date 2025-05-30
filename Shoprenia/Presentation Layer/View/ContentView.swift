import SwiftUI
import MobileBuySDK

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            MainTabView(path: $path)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .search :
                       ProductsView()
                    case .cart:
                        PlaceholderView()
                    case .favorites:
                        PlaceholderView()
                    case .Products(let vendor):
                        ProductsView(vendor: vendor)
                    }
                }
        }
    }
}
    

#Preview {
    ContentView()
}
