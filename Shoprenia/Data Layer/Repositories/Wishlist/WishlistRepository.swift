import Foundation



final class WishlistRepository : WishlistRepositoryProtocol {
    
    private let firestore : FireStoreServicesProtocol
    
    init(firestore: FireStoreServicesProtocol) {
        self.firestore = firestore
    }
    
    func fetchWishlistFirestore(completion: @escaping (Result<[FirestoreShopifyProduct], any Error>) -> Void) {
        firestore.fetchWishlistFirestore(completion: completion)
    }
    
    func deleteFromWishlist(productId: String) {
        firestore.deleteFromWishlist(productId: productId)
    }
    
}
