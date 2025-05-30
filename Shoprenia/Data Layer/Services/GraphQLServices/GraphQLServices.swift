import Foundation
import MobileBuySDK

class GraphQLServices : GraphQLServicesProtocol {
    
    static let shared = GraphQLServices()
    
    let client: Graph.Client
    
    var accessToken: String?
    
    private init() {
        self.client = Graph.Client(shopDomain: ShopifyKeys.shopDomain.rawValue, apiKey: ShopifyKeys.storefrontToken.rawValue)
    }
    
    func fetchProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void) {
        //Build Query
        let query = Storefront.buildQuery { $0
            .products(first: 20) { $0
                .edges { $0
                    .cursor()
                    .node{ $0
                        .title()
                        .id()
                    }
                }
            }
        }
        
        // Call the Database Request
        client.queryGraphWith(query) { queryResponse, error in
            guard let edges = queryResponse?.products.edges else {
                print(error!.localizedDescription)
                completion(.failure(error!))
                return
            }
            
            
            let products: [Storefront.Product] = edges.compactMap { edge in
                edge.node
            }
            
            completion(.success(products))
            //Execute the call
        }.resume()
    }
    
    
    func fetchProductDetails(
        id: GraphQL.ID,
        completion: @escaping (Result<Storefront.Product,Error>) -> Void){
        
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
                    .values()
                    
                }
                .featuredImage { $0
                    .url()
                }
            }
        }
        
            // Call the Database Request
            client.queryGraphWith(query) { queryResponse, error in
                guard let details = queryResponse?.product else {
                    print(error!.localizedDescription)
                    completion(.failure(error!))
                    return
                }
                
                
                let productDetails: Storefront.Product = details
                
                completion(.success(productDetails))
                //Execute the call
            }.resume()
    }
    
    
    func loginCustomer(email : String , password : String , completionhandler : @escaping (Bool) -> Void){
        let mutation = Storefront.buildMutation { $0
            .customerAccessTokenCreate(input: Storefront.CustomerAccessTokenCreateInput.create(email: email, password: password)) { $0
                .customerAccessToken { $0
                    .accessToken()
                    .expiresAt()
                }.customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }
        
        client.mutateGraphWith(mutation) { mutationResponse, error in
            guard let accessToken = mutationResponse?.customerAccessTokenCreate?.customerAccessToken?.accessToken else {
                print(error!.localizedDescription)
                completionhandler(false)
                return
            }
            
            self.accessToken = accessToken
            completionhandler(true)
        }.resume()
    }
    
    
    func createCustomer(email : String , password : String ,firstName : String, lastName : String, phone : String, acceptsMarketing : String,  completionhandler : @escaping (Bool) -> Void){
        let mutation = Storefront.buildMutation { $0
            .customerAccessTokenCreate(input: Storefront.CustomerAccessTokenCreateInput.create(email: email, password: password)) { $0
                .customerAccessToken { $0
                    .accessToken()
                    .expiresAt()
                }.customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }
        
        client.mutateGraphWith(mutation) { mutationResponse, error in
            guard let accessToken = mutationResponse?.customerAccessTokenCreate?.customerAccessToken?.accessToken else {
                print(error!.localizedDescription)
                completionhandler(false)
                return
            }
            
            self.accessToken = accessToken
            completionhandler(true)
        }.resume()
    }
    
    
    func fetchCustomer(completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void){
        guard let accessToken = accessToken else{
            return
        }
        
        let query = Storefront.buildQuery { $0
            .customer(customerAccessToken: accessToken) { $0
                .firstName()
                .id()
                .lastName()
            }
        }
        
        client.queryGraphWith(query) { queryResponse, error in
            guard let customer = queryResponse?.customer else {
                completionHandler(.failure(error!))
                return
            }
            completionHandler(.success(customer))
        }.resume()
    }
    
    
    func fetchVendors(completionHandler : @escaping (Result<Storefront.Collection,Error>)->Void){
        let query = Storefront.buildQuery { $0
            .collections(first:10 ){ $0
                .nodes{ $0
                    .id()
                    .title()
                }
            }
        }
        
        client.queryGraphWith(query) { queryResponse, error in
            guard let title = queryResponse?.collections.nodes.first?.title else {
                print(error?.localizedDescription ?? "error")
                completionHandler(.failure(error!))
                return
            }
            print(title)
            
        }.resume()
    }
}
