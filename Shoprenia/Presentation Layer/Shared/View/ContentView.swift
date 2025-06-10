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
            let addressVM = container.resolve(AddressViewModel.self)
            MainTabView(path: $path, homeVM: homeVM, categoriesVM: categoryVM)
                .navigationDestination(for: AppRouter.self) { route in
                    switch route {
                    case .search :
                        let productsVM = self.container.resolve(ProductsViewModel.self)
                       ProductsView(viewModel: productsVM, path: $path)
                    case .cart:
                        CartView(path: $path)
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
                        let addressVM = container.resolve(AddressViewModel.self)
                        SettingsView(viewModel : addressVM, path:$path)
                    case .pastOrders:
                        OrderHistory()
                    case .shippingAddresses:
                        AddressSelectionView(path:$path)
                    case .paymentMethods:
                        PaymentView()
                    case .invoice:
                        InvoiceView(path:$path)
                    case .AboutUs:
                        AboutUs()
                    case .HelpCenter:
                        HelpCenter().offset(y: 70)
                    case .addresses:
                       // let addressVM = container.resolve(AddressViewModel.self)
                        Addresses(viewModel: addressVM, path: $path)
                    case .addAddressFromMap:
                       // let addressVM = container.resolve(AddressViewModel.self)
                        AddFromMap(path: $path, viewModel: addressVM)
                    case .addressDetails(lat: let lat, lon: let lon):
                        //let addressVM = container.resolve(AddressViewModel.self)
                        SelectedAddDetails(latitude: lat, longitude: lon, viewModel: addressVM, path: $path)
                    }
                }
        }
    }
}
    

#Preview {
    ContentView()
}
