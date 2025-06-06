import SwiftUI
import MobileBuySDK

struct ContentView: View {
    @State private var path = NavigationPath()
    var body: some View {
        NavigationStack(path: $path){
            MainTabView(path: $path)
                .navigationDestination(for: AppRouter.self) { route in
                    switch route {
                    case .search :
                       ProductsView(path: $path)
                    case .cart:
                        PlaceholderView()
                    case .favorites:
                        PlaceholderView()
                    case .products(let vendor):
                        ProductsView(path: $path, vendor: vendor)
                    case .productDetails(productId: let productId):
                        ProductDetailsView(productId: productId.rawValue, path: $path)
                    case .login:
                        LoginView()
                    case .register:
                        RegisterationView()
                    }
                }
        }
    }
}
    

#Preview {
    ContentView()
}
