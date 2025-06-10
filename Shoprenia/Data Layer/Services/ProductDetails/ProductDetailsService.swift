import Foundation
import MobileBuySDK
import FirebaseFirestore
import FirebaseAuth

class ProductDetailsService: ProductDetailsServiceProtocol {
    
    private let userId : String
    private let db : Firestore
    private var isProductExist : Bool = false
    init() {
        userId = Auth.auth().currentUser?.uid ?? ""
        db = Firestore.firestore()
        print("User id is \(userId)")
    }
    
    func fetchProductDetails(
        id: MobileBuySDK.GraphQL.ID,
        completion: @escaping (Result<MobileBuySDK.Storefront.Product, any Error>) -> Void) {
            
            let query = Storefront.buildQuery { $0
                
                .product(id: id){ $0
                    
                    .availableForSale()
                    .description()
                    .id()
                    .isGiftCard()
                    .title()
                    .totalInventory()
                    .vendor()
                    .productType()
                    .tags()
                    .variants(first: 1){ $0
                        .nodes{ $0
                            .currentlyNotInStock()
                            .price { $0
                                .amount()
                                .currencyCode()
                            }
                        }
                    }
                    .options(first: 2){ $0
                        .name()
                        .id()
                        .optionValues { $0
                            .id()
                            .name()
                        }
                        
                    }
                    .featuredImage { $0
                        .url()
                    }
                }
            }
            
            GraphQLClientService.shared.client.queryGraphWith(query) { queryResponse, error in
                guard let details = queryResponse?.product else {
                    guard let error = error else {return}
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                let productDetails: Storefront.Product = details
                completion(.success(productDetails))
            }.resume()
            
    }
    
    func saveToFirestoreIfProductNotExist(product: FirestoreShopifyProduct) {
    
        db.collection("users")
            .document(userId)
            .collection("wishlist")
            .whereField("id", isEqualTo: product.id)
            .getDocuments {[weak self] (querySnapshot, error) in
                        if let error = error {
                            print("Error getting documents: \(error)")
                            return
                        }
                            
                        if let documents = querySnapshot?.documents, !documents.isEmpty {
                                print("Product exists // not saving")
                                return
                        } else {
                                print("No product found // saving")
                                self?.saveToFireStore(product: product)
                        }
            }
    }
    
    func saveToFireStore(product: FirestoreShopifyProduct) {
        
            do{
               
                try db.collection("users")
                            .document(userId)
                            .collection("wishlist")
                            .addDocument(from: product) { error in
                                if let error = error {
                                    print("Error saving: \(error)")
                                    
                                } else {
                                    print("Saved \(product.title)")
                                    
                                }
                            }
            }catch {
                    print("Error encoding product: \(error)")
                    
                }
    }
}
