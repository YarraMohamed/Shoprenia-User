//
//  DIContainer.swift
//  Shoprenia
//
//  Created by Yara Mohamed on 06/06/2025.
//

import Foundation
import Swinject

final class DIContainer {
    static let shared = DIContainer()

    let container: Container
    let assembler: Assembler

    private init() {
        container = Container()
         assembler = Assembler([
            HomeAssembly(),
            CategoryAssembly(),
            AuthAssembly(),
            ProductsAssembly(),
            AddressesAssembly(),
            ProductDetailsAssembly(),
            LoginAssembly(),
            RegisterationAssembly(),
            WishlistAssembly(),
            CartAssembly(),
            SelectedAddressAssembly(),
            OrderHistoryAssembly(),
            PaymentAssembly()
        ], container: container)
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        return assembler.resolver.resolve(type)!
    }

   final class HomeAssembly : Assembly{
        func assemble(container: Container) {

            container.register(VendorService.self) { _ in
                VendorService()
            }
            
            container.register(VendorsRepository.self) { resolver in
                VendorsRepository(vendorService: resolver.resolve(VendorService.self)!)
            }
            
            container.register(GetVendors.self) { resolver in
                GetVendors(repository: resolver.resolve(VendorsRepository.self)!)
            }
            
            container.register(HomeViewModel.self) { resolver in
                HomeViewModel(fetchBrandsUseCase: resolver.resolve(GetVendors.self)!)
            }
        }
    }

    final class CategoryAssembly : Assembly{
        func assemble(container: Container) {
            container.register(ProductService.self) { _ in
                ProductService()
            }
            container.register(ProductsRepository.self) { resolver in
                ProductsRepository(productService: resolver.resolve(ProductService.self)!)
            }
            container.register(GetProducts.self) { resolver in
                GetProducts(repository: resolver.resolve(ProductsRepository.self)!)
            }
            container.register(CategoriesViewModel.self) { resolver in
                CategoriesViewModel(fetchProductsUseCase: resolver.resolve(GetProducts.self)!)
            }
        }
    }

    final class ProductsAssembly : Assembly{
        func assemble(container: Container) {
            container.register(ProductService.self) { _ in
                ProductService()
            }
            container.register(ProductsRepository.self) { resolver in
                ProductsRepository(productService: resolver.resolve(ProductService.self)!)
            }
            container.register(GetProducts.self) { resolver in
                GetProducts(repository: resolver.resolve(ProductsRepository.self)!)
            }
            container.register(ProductsViewModel.self) { resolver in
                ProductsViewModel(fetchProductsUseCase: resolver.resolve(GetProducts.self)!)
            }
        }
    }


    final class AddressesAssembly : Assembly{
        func assemble(container: Container) {
            container.register(AddressService.self) { _ in
                AddressService()
            }
            container.register(AddressRepository.self) { resolver in
                AddressRepository(addressService: resolver.resolve(AddressService.self)!)
            }
            container.register(AddCustomerAddressUseCase.self) { resolver in
                AddCustomerAddressUseCase(repository: resolver.resolve(AddressRepository.self)!)
            }
            
            container.register(LogoutFromGoogle.self) { resolver in
                LogoutFromGoogle(repository: resolver.resolve(AddressRepository.self)!)
            }
            
            container.register(LogoutFromFirebase.self) { resolver in
                LogoutFromFirebase(repository: resolver.resolve(AddressRepository.self)!)
            }
            
            container.register(RemoveAllUserDefaultsValues.self) { resolver in
                RemoveAllUserDefaultsValues(repository: resolver.resolve(AddressRepository.self)!)
            }
            
            container.register(AddressViewModel.self) { resolver in
                AddressViewModel(addAddressUseCase: resolver.resolve(AddCustomerAddressUseCase.self)!, googleSignoutUseCase: resolver.resolve(LogoutFromGoogle.self)!, firebaseSignoutUseCase: resolver.resolve(LogoutFromFirebase.self)!,removeDefaults: resolver.resolve(RemoveAllUserDefaultsValues.self)!)
            }
        }
    }


    final class AuthAssembly : Assembly{
        func assemble(container: Container) {
            container .register(AuthenticationViewModel.self) { _ in
                AuthenticationViewModel(userDefaults: UserDefaultsManager.shared)
            }
        }
    }

    final class RegisterationAssembly : Assembly{
        func assemble(container: Container) {
            container.register(CredentialsValidation.self) { _ in
                CredentialsValidation()
            }
            container.register(CustomerServices.self) { _ in
                CustomerServices()
            }
            container.register(RegistrationRepo.self) { resolver in
                RegistrationRepo(firebaseService: FirebaseAuthenticationManager.shared,
                                 googleService: GoogleAuthenticationServices.shared,
                                 customerService: resolver.resolve(CustomerServices.self)!)
            }
            container.register(RegistarationViewModel.self) { resolver in
                RegistarationViewModel(credentialValidator: resolver.resolve(CredentialsValidation.self)!,
                                       registraionRepo: resolver.resolve(RegistrationRepo.self)!,
                                       userDefaultsManager: UserDefaultsManager.shared)
            }
        }
    }

    final class LoginAssembly : Assembly{
        func assemble(container: Container) {
            container.register(CredentialsValidation.self) { _ in
                CredentialsValidation()
            }
            container.register(CustomerServices.self) { _ in
                CustomerServices()
            }
            container.register(LoginRepo.self) { resolver in
                LoginRepo(firebaseService: FirebaseAuthenticationManager.shared,
                          googleService: GoogleAuthenticationServices.shared,
                          customerService: resolver.resolve(CustomerServices.self)!)
            }
            container.register(LoginViewModel.self) { resolver in
                LoginViewModel(credentialValidator: resolver.resolve(CredentialsValidation.self)!,
                               userDefaultsManager: UserDefaultsManager.shared,
                               loginRepo: resolver.resolve(LoginRepo.self)!)
            }
        }
    }

    final class ProductDetailsAssembly : Assembly{
        
        func assemble(container: Container) {
            container.register(ProductDetailsService.self) { _ in
                ProductDetailsService()
            }
            container.register(ProductDetailsRepository.self) { resolver in
                ProductDetailsRepository(service: resolver.resolve(ProductDetailsService.self)!)
            }
            container.register(GetProductDetailsUseCase.self) { resolver in
                GetProductDetailsUseCase(repo: resolver.resolve(ProductDetailsRepository.self)!)
            }
            container.register(SaveToFirestore.self) { resolver in
                SaveToFirestore(repo: resolver.resolve(ProductDetailsRepository.self)!)
            }
            container.register(ProductDetailsViewModel.self) { resolver in
                ProductDetailsViewModel(productDetailsCase: resolver.resolve(GetProductDetailsUseCase.self)!, saveToFirestoreCase: resolver.resolve(SaveToFirestore.self)!,cartUseCase: resolver.resolve(CartUsecase.self)!)
            }
        }
    }

    final class WishlistAssembly: Assembly{
        
        func assemble(container: Container){
            
            container.register(FireStoreServices.self){ _ in
                FireStoreServices()
            }
            
            container.register(WishlistRepository.self){ resolver in
                WishlistRepository(firestore: resolver.resolve(FireStoreServices.self)!)
            }
            
            container.register(DeleteFromWishlist.self){ resolver in
                DeleteFromWishlist(repo: resolver.resolve(WishlistRepository.self)!)
            }
            
            container.register(FetchWishlistFromFirestore.self){ resolver in
                FetchWishlistFromFirestore(repo: resolver.resolve(WishlistRepository.self)!)
            }
            
            container.register(WishlistViewModel.self){ resolver in
                WishlistViewModel(deleteFromWishlistCase: resolver.resolve(DeleteFromWishlist.self)!, fetchwishlistCase: resolver.resolve(FetchWishlistFromFirestore.self)!)
            }
        }
    }
    
    final class CartAssembly : Assembly{
        func assemble(container: Container) {
            container.register(CartService.self) { _ in
                CartService()
            }
            container.register(CartRepository.self) { resolver in
                CartRepository(service: resolver.resolve(CartService.self)!)
            }
            container.register(CartUsecase.self) { resolver in
                CartUsecase(repository: resolver.resolve(CartRepository.self)!)
            }
            container.register(CartViewModel.self) { resolver in
                CartViewModel(cartUsecase: resolver.resolve(CartUsecase.self)!)
            }
        }
    }
    
    final class SelectedAddressAssembly : Assembly{
        func assemble(container: Container) {
            container.register(SelectedAddressViewModel.self) { resolver in
                SelectedAddressViewModel(cartUsecase: resolver.resolve(CartUsecase.self)!)
            }
        }
    }
    
    final class OrderHistoryAssembly : Assembly{
        func assemble(container: Container) {
            container.register(OrderHistoryService.self) { _ in
                OrderHistoryService()
            }
            container.register(OrderHistoryRepo.self) { resolver in
                OrderHistoryRepo(service: resolver.resolve(OrderHistoryService.self)!)
            }
            container.register(OrderHistoryUsecase.self){ resolver in
                OrderHistoryUsecase(repo: resolver.resolve(OrderHistoryRepo.self)!)
            }
            container.register(OrderHistoryViewModel.self) { resolver in
                OrderHistoryViewModel(usecase: resolver.resolve(OrderHistoryUsecase.self)!)
            }
        }
    }
    
    final class PaymentAssembly : Assembly{
        func assemble(container: Container) {
            container.register(PaymentService.self) { _ in
                PaymentService()
            }
            container.register(PaymentRepository.self) { resolver in
                PaymentRepository(service: resolver.resolve(PaymentService.self)!)
            }
            container.register(PaymentUsecase.self) { resolver in
                PaymentUsecase(repo: resolver.resolve(PaymentRepository.self)!)
            }
            container.register(PaymentViewModel.self) { resolver in
                PaymentViewModel(usecase: resolver.resolve(PaymentUsecase.self)!)
            }
        }
    }
    
}
