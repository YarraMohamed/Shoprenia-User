import Foundation
import MobileBuySDK

final class SaveToFirestore : SaveToFirestoreUseCaseProtocol {
    
    let repo : ProductDetailsRepoProtocol
    
    init(repo: ProductDetailsRepoProtocol) {
        self.repo = repo
    }
    
    func execute(product: FirestoreShopifyProduct) {
        repo.saveToFirestore(product: product)
    }
}

