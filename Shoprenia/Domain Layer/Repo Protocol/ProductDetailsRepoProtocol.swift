import Foundation
import MobileBuySDK

protocol ProductDetailsRepoProtocol{
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void)
}
