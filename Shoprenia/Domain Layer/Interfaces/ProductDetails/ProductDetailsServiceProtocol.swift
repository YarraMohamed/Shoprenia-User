import Foundation
import MobileBuySDK

protocol ProductDetailsServiceProtocol{
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void)
}
