//
//  CustomerAddress.swift
//  Shoprenia
//
//  Created by MAC on 03/06/2025.
//

struct CustomerAddress {
    var id: String?
    var addName: String
    var streetName: String
    var phoneNumber: String
    var buildingNumber: String?
    var floorNumber: String?
    var apartNumber: String?
    var landmark: String?
    var city: String
    var country: String
    var zip: String
    var latitude: Double 
    var longitude: Double
    
    static var empty: CustomerAddress {
        return CustomerAddress(
            addName: "", streetName: "", phoneNumber: "",
            buildingNumber: "", floorNumber: "", apartNumber: "",
            landmark: "", city: "", country: "", zip: "",
            latitude: 0.0, longitude: 0.0
        )
    }
}
