import Foundation
import MobileBuySDK

protocol ProductDetailsUsecaseProtocol{
    func getProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void)
}
