import Foundation
import MobileBuySDK


final class ProductDetailsViewModel:ObservableObject{
    
    @Published var productDetails : Storefront.Product? = nil
    private let productDetailsCase : ProductDetailsUsecaseProtocol
    private let saveToFirestoreCase : SaveToFirestoreUseCaseProtocol
    
    init(productDetailsCase: ProductDetailsUsecaseProtocol, saveToFirestoreCase: SaveToFirestoreUseCaseProtocol) {
        self.productDetailsCase = productDetailsCase
        self.saveToFirestoreCase = saveToFirestoreCase
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
    
    func saveShopifyProduct(_ item: Storefront.Product) {
    
        let firestoreProduct = FirestoreShopifyProduct(
            id: item.id.rawValue,
            title: item.title,
            brand: item.vendor,
            price: "\(item.variants.nodes.first?.price.amount ?? 0.00)",
            imageUrl: item.featuredImage?.url.absoluteString ?? "",
            currencyName: item.variants.nodes.first?.price.currencyCode.rawValue ?? "egp"
        )
        
        saveToFirestore(firestoreProduct)
    }
    
    private func saveToFirestore(_ product: FirestoreShopifyProduct){
        saveToFirestoreCase.execute(product: product)
    }
}
