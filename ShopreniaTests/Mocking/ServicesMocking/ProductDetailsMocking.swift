import Foundation
@testable import Shoprenia
import MobileBuySDK

class MockProductDetailsService: ProductDetailsServiceProtocol {
    var fetchCalled = false
    var saveCalled = false
    var shouldReturnError = false
    var mockProduct: Storefront.Product!

    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product, Error>) -> Void) {
        fetchCalled = true
        
        if shouldReturnError {
            completion(.failure(NSError(domain: "TestError", code: 1, userInfo: nil)))
        } else if let product = mockProduct {
            completion(.success(product))
        }
    }
    
    func saveToFirestoreIfProductNotExist(product: FirestoreShopifyProduct) {
        saveCalled = true
    }
}
