import Foundation


protocol WishlistRepositoryProtocol{
    func fetchWishlistFirestore(completion: @escaping (Result<[FirestoreShopifyProduct], Error>) -> Void)
    func deleteFromWishlist(productId: String)
}
