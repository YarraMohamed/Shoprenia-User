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
          let coordinateString = encodeCoordinates(lat: address.latitude, lon: address.longitude)

  
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
                      zip: coordinateString
                  )
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
                          print(" failed to set default address \(error.localizedDescription)")
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
                completion(.failure(NSError(domain: "error", code: -1)))
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
                        .country()
                        .zip()
                        .phone()
                        .latitude()
                        .longitude()
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
                completion(.failure(NSError(domain: "error", code: -1)))
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
        let coordinateString = encodeCoordinates(lat: address.latitude, lon: address.longitude)
        
        
        let mailingAddressInput = Storefront.MailingAddressInput(
            address1: address.streetName,
            address2: [
                "Build: \(address.buildingNumber ?? "")",
                "Floor: \(address.floorNumber ?? "")",
                "Landmark: \(address.landmark ?? "")"
            ].compactMap { $0 }.joined(separator: ", "),
            city: address.city,
            country: address.country.isEmpty ? " " : address.country,
            firstName: address.addName,
            lastName: address.apartNumber,
            phone: address.phoneNumber,
            zip: coordinateString
        )
        
        
        let mutation = Storefront.buildMutation { $0
            .customerAddressUpdate(
                customerAccessToken: accessToken,
                id: GraphQL.ID(rawValue: addressID),
                address: mailingAddressInput
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
        
        GraphQLClientService.shared.client.mutateGraphWith(mutation) { mutationResponse, error in
            if let error = error {
                print(" Mutation error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let userErrors = mutationResponse?.customerAddressUpdate?.customerUserErrors, !userErrors.isEmpty {
                let errorMessage = userErrors.map { $0.message }.joined(separator: ", ")
                print(" User errors: \(errorMessage)")
                completion(.failure(NSError(domain: errorMessage, code: -1)))
                return
            }
            
            guard let updatedAddress = mutationResponse?.customerAddressUpdate?.customerAddress else {
                completion(.failure(NSError(domain: "No address in response", code: -1)))
                return
            }
            
            if let zip = updatedAddress.zip {
            //    let coords = self.decodeCoordinates(zip)
              //  print(" Decoded Coordinates: \(coords)")
            }
            
            if setAsDefault {
                self.setDefaultAddress(addressID: updatedAddress.id.rawValue) { result in
                    completion(result.map { _ in updatedAddress })
                }
            } else {
                completion(.success(updatedAddress))
            }
        }.resume()
    }


    private func encodeCoordinates(lat: Double, lon: Double) -> String {
        let coordinateString = String(format: "%.14f,%.14f", lat, lon)
        return Data(coordinateString.utf8).base64EncodedString()
    }


//delete
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

 
