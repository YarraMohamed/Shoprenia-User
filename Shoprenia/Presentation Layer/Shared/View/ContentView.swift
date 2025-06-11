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
                    case .products(let vendor):
                        let productsVM = self.container.resolve(ProductsViewModel.self)
                        ProductsView(viewModel: productsVM,path: $path, vendor: vendor)
                    case .productDetails(productId: let productId):
                        let productDetailsVM = self.container.resolve(ProductDetailsViewModel.self)
                        ProductDetailsView(productId: productId, path: $path, viewModel: productDetailsVM)
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
                        let selectedViewModel = container.resolve(SelectedAddressViewModel.self)
                        AddressSelectionView(path: $path, viewModel: addressVM, selectedViewModel: selectedViewModel)
                    case .paymentMethods:
                        PaymentView()
                    case .invoice:
                        InvoiceView(path:$path)
                    case .AboutUs:
                        AboutUs()
                    case .HelpCenter:
                        HelpCenter().offset(y: 70)
                    case .addresses:
                        Addresses(viewModel: addressVM, path: $path)
                    case .addAddressFromMap:
                        AddFromMap(path: $path, viewModel: addressVM)
                    case .addressDetails(lat: let lat, lon: let lon):
                        SelectedAddDetails(latitude: lat, longitude: lon, viewModel: addressVM, path: $path)
                    case .wishlist:
                        let wishlistVM = self.container.resolve(WishlistViewModel.self)
                        WishlistView(viewModel: wishlistVM, path: $path)
                    case .updateAddress(let address, let lat, let lon):
                        UpdateAddressMap(
                            selectedAddress: address,
                            initialLatitude: lat,
                            initialLongitude: lon,
                            path: $path
                        ).navigationDestination(for: String.self) { destination in
                            if destination == "UpdateAddressDetails" {
                                UpdateAddressDetails(
                                    selectedAddress: address,
                                    latitude: 30.0,
                                    longitude: 31.0,
                                    path: $path
                                )
                            }
                        }
                    }
                }
        }
    }
}
    

#Preview {
    ContentView()
}
