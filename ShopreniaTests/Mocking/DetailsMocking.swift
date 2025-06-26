
import Foundation
@testable import Shoprenia
import MobileBuySDK
class MockProductDetailsUseCase: ProductDetailsUsecaseProtocol {
    var productToReturn: Storefront.Product?
    func getProductDetails(id: GraphQL.ID, completion: @escaping (Result<Storefront.Product, Error>) -> Void) {
        if let product = productToReturn {
            completion(.success(product))
        } else {
            completion(.failure(NSError(domain: "Test", code: 0)))
        }
    }
}

class MockSaveToFirestoreUseCase: SaveToFirestoreUseCaseProtocol {
    var savedProduct: FirestoreShopifyProduct?
    func execute(product: FirestoreShopifyProduct) {
        savedProduct = product
    }
}

class MockCartUseCase: CartUsecaseProtocol {
    var shouldSucceed = true
    var mockedCart: Storefront.Cart!

    func addToCart(variantId: String, quantity: Int, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        shouldSucceed
            ? completion(.success(mockedCart))
            : completion(.failure(NSError(domain: "Test", code: 0)))
    }

    func removeFromCart(lineId: String, completion: @escaping (Result<Storefront.Cart, Error>) -> Void) {
        shouldSucceed
            ? completion(.success(mockedCart))
            : completion(.failure(NSError(domain: "Test", code: 0)))
    }
    
    func updateCartQuantity(lineId: String, newQuantity: Int, completion: @escaping (Result<MobileBuySDK.Storefront.Cart, any Error>) -> Void) {
        
    }
    
    func fetchCart(completion: @escaping (Result<MobileBuySDK.Storefront.Cart, any Error>) -> Void) {
        
    }
    
    func setAddressInCart(address: MobileBuySDK.Storefront.MailingAddress, completion: @escaping (Result<MobileBuySDK.Storefront.CartSelectableAddress, any Error>) -> Void) {
        
    }
    
    func checkVariantAvailability(variantId: String, completion: @escaping (Result<Bool, any Error>) -> Void) {
        
    }
    
}
