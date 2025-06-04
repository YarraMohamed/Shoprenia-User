import Foundation
import MobileBuySDK


final class ProductDetailsViewModel:ObservableObject{
    
    @Published var productDetails : Storefront.Product? = nil
    private let productDetailsCase : GetProductDetailsUseCase
    
    init(productDetailsCase: GetProductDetailsUseCase) {
        self.productDetailsCase = productDetailsCase
    }
    
    func getProductDetails(id: GraphQL.ID){
        productDetailsCase.getProductDetails(id: id) { result in
            switch result{
            case .success(let productDetails) :
                self.productDetails = productDetails
            case .failure(let error) :
                print("Error \(error)")
            }
        }
    }
}
