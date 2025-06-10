import Foundation


protocol FetchWishlistFromFirestoreProtocol{
    func execute(completion: @escaping (Result<[FirestoreShopifyProduct], Error>) -> Void)
}
