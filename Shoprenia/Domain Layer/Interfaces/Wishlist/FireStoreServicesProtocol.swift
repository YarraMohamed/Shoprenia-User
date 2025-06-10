import Foundation


protocol FireStoreServicesProtocol {
    func fetchWishlistFirestore(completion: @escaping (Result<[FirestoreShopifyProduct], Error>) -> Void)
    func deleteFromWishlist(productId: String)
}
