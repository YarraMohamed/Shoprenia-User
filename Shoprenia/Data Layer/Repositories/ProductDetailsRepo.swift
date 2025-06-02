import Foundation
import MobileBuySDK


final class ProductDetailsRepo : ProductDetailsRepoProtocol{
    static let shared = ProductDetailsRepo()
    private let remoteSource : RemoteDataSourceProtocol
   
    private init(remoteSource : RemoteDataSourceProtocol = RemoteDataSource.shared){
        self.remoteSource = remoteSource
    }
    
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void){
            remoteSource.fetchProductDetails(id: id, completion: completion)
        }
}
