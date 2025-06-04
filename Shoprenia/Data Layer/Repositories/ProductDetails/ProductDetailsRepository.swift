
import Foundation
import MobileBuySDK

class ProductDetailsRepository: ProductDetailsRepoProtocol {
    
    let service : ProductDetailsServiceProtocol
    
    init(service: ProductDetailsServiceProtocol) {
        self.service = service
    }
    
    func fetchProductDetails(
        id: MobileBuySDK.GraphQL.ID,
        completion: @escaping (Result<MobileBuySDK.Storefront.Product, any Error>) -> Void) {
            service.fetchProductDetails(id: id, completion: completion)
    }
}
