import Foundation

struct FirestoreShopifyProduct: Codable,Identifiable {
    let id: String
    let title: String
    let brand: String
    let price: String
    let imageUrl: String
    let currencyName: String
}
