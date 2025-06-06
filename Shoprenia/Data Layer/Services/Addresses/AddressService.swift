//
//  AddressService.swift
//  Shoprenia
//
//  Created by Reham on 03/06/2025.
//

import Foundation
import MobileBuySDK

class AddressService: AddressServiceProtocol {
    func addCustomerAddress(
        address: CustomerAddress,
        setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void
    ) {
        let accessToken = getCustomerAccessToken()

        let mutation = Storefront.buildMutation { $0
            .customerAddressCreate(
                customerAccessToken: accessToken,
                address: Storefront.MailingAddressInput(
                    address1: address.streetName,
                    address2: [
                        "Build: \( address.buildingNumber ?? "")",
                        "Floor: \(address.floorNumber ?? "")",
                        "Landmark: \(address.landmark ?? "")"
                    ].compactMap { $0 }.joined(separator: ", "), 
                    city: address.city,
                    country: address.country,
                    firstName: address.addName,
                    lastName: address.apartNumber,
                    phone: address.phoneNumber,
                    zip: "\(address.latitude),\(address.longitude)"               )
            ) { $0
                .customerAddress { $0
                    .id()
                }
                .customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }

        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutation, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let createdAddress = mutation?.customerAddressCreate?.customerAddress else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }

            if setAsDefault {
                self.setDefaultAddress(addressID: createdAddress.id.rawValue) { result in
                    switch result {
                    case .success:
                        print(" Address set as default successfully")
                    case .failure(let error):
                        print(" Failed to set default address: \(error.localizedDescription)")
                    }
                }
            }

            completion(.success(createdAddress))
        }.resume()
    }

    func setDefaultAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let accessToken = getCustomerAccessToken()

        let mutation = Storefront.buildMutation { $0
            .customerDefaultAddressUpdate(
                customerAccessToken: accessToken,
                addressId: GraphQL.ID(rawValue: addressID)
            ) { $0
                .customer { $0
                    .defaultAddress { $0
                        .id()
                    }
                }
                .customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }

        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutation, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard mutation?.customerDefaultAddressUpdate?.customer?.defaultAddress != nil else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }

            completion(.success(true))
        }.resume()
    }

  
    func getCustomerAddresses(completion: @escaping (Result<([Storefront.MailingAddress], String?), Error>) -> Void){

        let accessToken = getCustomerAccessToken()

        let query = Storefront.buildQuery { $0
            .customer(customerAccessToken: accessToken) { $0
                .defaultAddress { $0.id() }
                .addresses(first: 10) { $0
                    .nodes { $0
                        .id()
                        .firstName()
                        .lastName()
                        .address1()
                        .address2()
                        .city()
                        .province()
                        .country()
                        .zip()
                        .phone()
                    }
                }
            }
        }

        GraphQLClientService.shared.client.queryGraphWith(query) { query, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let customer = query?.customer else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }

            let addresses = customer.addresses.nodes
            let defaultAddressID = customer.defaultAddress?.id.rawValue

            completion(.success((addresses, defaultAddressID)))

        }.resume()
    }

    
    
// update
    func updateCustomerAddress(
        addressID: String,
        address: CustomerAddress,
        setAsDefault: Bool,
        completion: @escaping (Result<Storefront.MailingAddress, Error>) -> Void
    ) {
        let accessToken = getCustomerAccessToken()

        let mutation = Storefront.buildMutation { $0
            .customerAddressUpdate(
                customerAccessToken: accessToken,
                id: GraphQL.ID(rawValue: addressID),
                address: Storefront.MailingAddressInput(
                    address1: address.streetName,
                    address2: [
                        "Build: \(address.buildingNumber ?? "")",
                        "Floor: \(address.floorNumber ?? "")",
                        "Landmark: \(address.landmark ?? "")"
                    ].compactMap { $0 }.joined(separator: ", "),
                    city: address.city,
                    country: address.country,
                    firstName: address.addName,
                    lastName: address.apartNumber,
                    phone: address.phoneNumber,
                    zip: address.zip
                )
            ) { $0
                .customerAddress { $0
                    .id()
                    .address1()
                    .address2()
                    .city()
                    .country()
                    .zip()
                    .phone()
                }
                .customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }

        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutation, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            if let userErrors = mutation?.customerAddressUpdate?.customerUserErrors, !userErrors.isEmpty {
                let errorMessage = userErrors.map {
                    let fields = $0.field?.joined(separator: ", ") ?? "Unknown field"
                    return "\(fields): \($0.message)"
                }.joined(separator: ", ")
                completion(.failure(NSError(domain: errorMessage, code: -1)))
                return
            }

            guard let updatedAddress = mutation?.customerAddressUpdate?.customerAddress else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }

            if setAsDefault {
                self.setDefaultAddress(addressID: updatedAddress.id.rawValue) { result in
                    switch result {
                    case .success:
                        print("Address set as default")
                    case .failure(let error):
                        print(" Failed to set default : \(error.localizedDescription)")
                    }
                }
            }

            completion(.success(updatedAddress))
        }.resume()
    }

 

    func deleteCustomerAddress(addressID: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        let accessToken = getCustomerAccessToken()

        let mutation = Storefront.buildMutation { $0
            .customerAddressDelete(id: GraphQL.ID(rawValue: addressID) ,  customerAccessToken: accessToken) { $0
                .deletedCustomerAddressId()
                .customerUserErrors { $0
                    .field()
                    .message()
                }
            }
        }

        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutation, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let deletedAddressID = mutation?.customerAddressDelete?.deletedCustomerAddressId else {
                completion(.failure(NSError(domain: "Unknown error", code: -1)))
                return
            }

            print("Address deleted successfully: \(deletedAddressID)")
            completion(.success(true))
        }.resume()
    }


    private func getCustomerAccessToken() -> String {
        return UserDefaultsManager.shared.retrieveShopifyCustomerAccessToken() ?? ""
    }
    
}

 
