import Foundation


final class DeleteFromWishlist : DeleteFromWishlistUseCaseProtocol {

    private let repo : WishlistRepositoryProtocol
    
    init(repo: WishlistRepositoryProtocol) {
        self.repo = repo
    }
    
    func execute(productId: String) {
        repo.deleteFromWishlist(productId: productId)
    }
    
}
