import Foundation
import MobileBuySDK

class CustomerServices : CustomerServicesProtocol {
    
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
        
        
        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutationResponse, error in
            guard let createdCustomer = mutationResponse?.customerCreate?.customer else {
                guard let error = error else {return}
                print(error)
                completion(.failure(error))
                return
            }
            
            
            completion(.success(createdCustomer))
        }.resume()
    }
    
    func createCustomerWithoutPhone(email : String ,
                        password : String ,
                        firstName : String,
                        lastName : String,
                        completion: @escaping (Result<Storefront.Customer,Error>) -> Void){

        let mutation = Storefront.buildMutation{$0
            .customerCreate(input: Storefront.CustomerCreateInput.create(email: email, password: password, firstName: .value(firstName), lastName: .value(lastName))) { $0
                
                .customer { $0
                    .id()
                    .firstName()
                    .lastName()
                    .email()
                    .displayName()
                    .createdAt()
                    
                }
                .customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }
        
        
        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutationResponse, error in
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
        
        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutationResponse, error in
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
        
        GraphQLClientService.shared.client.queryGraphWith(query) { queryResponse, error in
            guard let customer = queryResponse?.customer else {
                guard let error = error else { return }
                completionHandler(.failure(error))
                return
            }
            completionHandler(.success(customer))
        }.resume()
    }
}
