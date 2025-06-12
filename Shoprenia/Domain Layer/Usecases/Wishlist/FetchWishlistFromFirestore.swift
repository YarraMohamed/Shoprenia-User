import Foundation


final class FetchWishlistFromFirestore : FetchWishlistFromFirestoreProtocol{

    private let repo : WishlistRepositoryProtocol
    
    
    init(repo: WishlistRepositoryProtocol) {
        self.repo = repo
    }
    
    
    func execute(completion: @escaping (Result<[FirestoreShopifyProduct], any Error>) -> Void) {
        repo.fetchWishlistFirestore(completion: completion)
    }
    
}
