import SwiftUI
import Swinject
import MobileBuySDK

struct ContentView: View {
    @State private var path = NavigationPath()
    private let container = DIContainer.shared

    var body: some View {
        NavigationStack(path: $path){
            let homeVM = container.resolve(HomeViewModel.self)
            let categoryVM = container.resolve(CategoriesViewModel.self)
            MainTabView(path: $path, homeVM: homeVM, categoriesVM: categoryVM)
                .navigationDestination(for: AppRouter.self) { route in
                    switch route {
                    case .search :
                        let productsVM = self.container.resolve(ProductsViewModel.self)
                       ProductsView(viewModel: productsVM, path: $path)
                    case .cart:
                        PlaceholderView()
                    case .favorites:
                        PlaceholderView()
                    case .products(let vendor):
                        let productsVM = self.container.resolve(ProductsViewModel.self)
                        ProductsView(viewModel: productsVM,path: $path, vendor: vendor)
                    case .productDetails(productId: let productId):
                        let productDetailsVM = self.container.resolve(ProductDetailsViewModel.self)
                        ProductDetailsView(productId: productId.rawValue, viewModel: productDetailsVM, path: $path)
                    case .login:
                        let loginVM = self.container.resolve(LoginViewModel.self)
                        LoginView(viewModel: loginVM,path:$path)
                    case .register:
                        let registerationVM = self.container.resolve(RegistarationViewModel.self)
                        RegisterationView(viewModel: registerationVM,path:$path)
                    case .profile:
                        ProfileView(path: $path)
                    case .settings:
                        SettingsView()
                    }
                }
        }
    }
}
    

#Preview {
    ContentView()
}
