import Foundation
import MobileBuySDK

protocol GraphQLServicesProtocol {
    
    func fetchProducts(completion: @escaping (Result<[Storefront.Product], Error>) -> Void)
    func loginCustomer(email : String , password : String , completionhandler : @escaping (Bool) -> Void)
    func fetchCustomer(completionHandler : @escaping (Result<Storefront.Customer,Error>)->Void)
    func fetchVendors(completionHandler : @escaping (Result<Storefront.Collection,Error>)->Void)
    func fetchProductDetails(id: GraphQL.ID,completion: @escaping (Result<Storefront.Product,Error>) -> Void)
    
}
