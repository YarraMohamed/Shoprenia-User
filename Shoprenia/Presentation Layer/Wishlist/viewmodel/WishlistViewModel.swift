import Foundation


final class WishlistViewModel : ObservableObject{
    
    private let deleteFromWishlistCase : DeleteFromWishlistUseCaseProtocol
    private let fetchwishlistCase : FetchWishlistFromFirestoreProtocol
    @Published var wishlist : [FirestoreShopifyProduct] = []
    
    init(deleteFromWishlistCase: DeleteFromWishlistUseCaseProtocol,
         fetchwishlistCase: FetchWishlistFromFirestoreProtocol) {
        self.deleteFromWishlistCase = deleteFromWishlistCase
        self.fetchwishlistCase = fetchwishlistCase
    }
    
    
    func fetchWishlistFromFireStore() {
        
        fetchwishlistCase.execute{[weak self] result in
            switch result {
            case .success(let wishlist):
                self?.wishlist = wishlist
            case .failure(let error):
                print("error fetching wishlist \(error)")
            }
        }
    }
    
    func deleteProductFromFirestore(productId: String) {
        deleteFromWishlistCase.execute(productId: productId)
    }
}
