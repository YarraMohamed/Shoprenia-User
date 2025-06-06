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
            ProductDetailsAssembly(),
            LoginAssembly(),
            RegisterationAssembly()
        ], container: container)
    }
    
    func resolve<T>(_ type: T.Type) -> T {
        return assembler.resolver.resolve(type)!
    }
}

final class AuthAssembly : Assembly{
    func assemble(container: Container) {
        container .register(AuthenticationViewModel.self) { _ in
            AuthenticationViewModel(userDefaults: UserDefaultsManager.shared)
        }
    }
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
        container.register(ProductDetailsViewModel.self) { resolver in
            ProductDetailsViewModel(productDetailsCase: resolver.resolve(GetProductDetailsUseCase.self)!)
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

