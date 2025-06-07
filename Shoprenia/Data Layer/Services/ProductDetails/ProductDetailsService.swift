
import Foundation
import MobileBuySDK

class ProductDetailsService: ProductDetailsServiceProtocol {
    
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
}
