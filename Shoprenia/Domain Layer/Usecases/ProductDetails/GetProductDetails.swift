
import Foundation
import MobileBuySDK

class GetProductDetailsUseCase : ProductDetailsUsecaseProtocol{
    
    let repo : ProductDetailsRepoProtocol
    
    init(repo: ProductDetailsRepoProtocol) {
        self.repo = repo
    }
    
    func getProductDetails(
        id: MobileBuySDK.GraphQL.ID,
        completion: @escaping (Result<MobileBuySDK.Storefront.Product, any Error>) -> Void) {
            repo.fetchProductDetails(id: id, completion: completion)
    }
    
}
