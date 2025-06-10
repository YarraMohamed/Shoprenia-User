import Foundation
import MobileBuySDK
import FirebaseFirestore
import FirebaseAuth



final class FireStoreServices : FireStoreServicesProtocol {
    
    private let userId : String
    private let db : Firestore
    private var isProductExist : Bool = false
    
    init() {
        userId = Auth.auth().currentUser?.uid ?? ""
        db = Firestore.firestore()
        print("User id is \(userId)")
    }
    
    
    func fetchWishlistFirestore(completion: @escaping (Result<[FirestoreShopifyProduct], Error>) -> Void) {
       
        db.collection("users")
            .document(userId)
            .collection("wishlist")
            .getDocuments { snapshot, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let documents = snapshot?.documents else {
                    completion(.success([]))
                    return
                }
                
                let products = documents.compactMap { document -> FirestoreShopifyProduct? in
                    do {
                        return try document.data(as: FirestoreShopifyProduct.self)
                    } catch {
                        print("Error decoding product: \(error)")
                        return nil
                    }
                }
                
                completion(.success(products))
            }
    }
    
    func deleteFromWishlist(productId: String) {
        
        db.collection("users")
            .document(userId)
            .collection("wishlist")
            .whereField("id", isEqualTo: productId)
            .getDocuments { snapshot, error in
                if let error = error {
                    print("Error in delete firestore")
                    return
                }
                
                guard let document = snapshot?.documents.first else {
                    print("No such product exist")
                    return
                }
                
                document.reference.delete { error in
                    if let error = error {
                       print("Can't deleteb product")
                    } else {
                        print("Deleted successfully")
                    }
                }
            }
    }
    
}
