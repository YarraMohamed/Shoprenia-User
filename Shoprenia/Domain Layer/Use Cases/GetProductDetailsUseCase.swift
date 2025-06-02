import Foundation
import MobileBuySDK


final class GetProductDetailsUseCase{
    
    private let productDetailsRepo : ProductDetailsRepoProtocol
    
    init(productDetailsRepo : ProductDetailsRepoProtocol = ProductDetailsRepo.shared){
        self.productDetailsRepo = productDetailsRepo
    }
    
    func getProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void){
            productDetailsRepo.fetchProductDetails(id: id, completion: completion)
        }
    
}
