import Foundation
import MobileBuySDK

class GraphQLServices : GraphQLServicesProtocol {
  
    static let shared = GraphQLServices()
    
    let client: Graph.Client
    
    private init() {
        self.client = Graph.Client(shopDomain: ShopifyKeys.shopDomain.rawValue, apiKey: ShopifyKeys.storefrontToken.rawValue)
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
        
            // Call the api with query Request
            client.queryGraphWith(query) { queryResponse, error in
                guard let details = queryResponse?.product else {
                    guard let error = error else {return}
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                
                
                let productDetails: Storefront.Product = details
                
                completion(.success(productDetails))
                //Execute the call
            }.resume()
    }
    
    
    func createCustomer(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        phone : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void){

        let mutation = Storefront.buildMutation{$0
            .customerCreate(input: Storefront.CustomerCreateInput.create(email: email, password: password, firstName: .value(firstName), lastName: .value(lastName), phone: .value(phone))) { $0
                
                .customer { $0
                    .id()
                    .firstName()
                    .lastName()
                    .email()
                    .phone()
                    .displayName()
                    .createdAt()
                    
                }
                .customerUserErrors { $0
                
                    .field()
                    .message()
                    
                }
            }
        }
        
        
        client.mutateGraphWith(mutation) { mutationResponse, error in
            guard let createdCustomer = mutationResponse?.customerCreate?.customer else {
                guard let error = error else {return}
                print(error)
                completion(.failure(error))
                return
            }
            
            
            completion(.success(createdCustomer))
        }.resume()
    }
    
    
    func createCustomerAccessToken(email : String , password : String , completionhandler : @escaping (Result<String, Error>) -> Void){
        
        let mutation = Storefront.buildMutation { $0
            .customerAccessTokenCreate(input: Storefront.CustomerAccessTokenCreateInput.create(email: email, password: password)) { $0
                .customerAccessToken { $0
                    .accessToken()
                }.customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }
        
        client.mutateGraphWith(mutation) { mutationResponse, error in
            guard let accessToken = mutationResponse?.customerAccessTokenCreate?.customerAccessToken?.accessToken else {
                guard let error = error else {return}
                completionhandler(.failure(error))
                return
            }
            
            completionhandler(.success(accessToken))
            //execute call
        }.resume()
    }
    
    
    func getCustomerByAccessToken(accessToken:String,completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void){
        
        let query = Storefront.buildQuery { $0
            .customer(customerAccessToken: accessToken) { $0
                .firstName()
                .lastName()
                .displayName()
                .email()
                .phone()
                .numberOfOrders()
                .id()
                
            }
        }
        
        client.queryGraphWith(query) { queryResponse, error in
            guard let customer = queryResponse?.customer else {
                guard let error = error else { return }
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(customer))
        }.resume()
    }
}
