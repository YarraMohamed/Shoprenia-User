import Foundation
import SwiftData

@Model
class ShopifyProduct {
    var availableForSale: Bool
    var productDescription: String
    var id: String
    var isGiftCard: Bool
    var title: String
    var totalInventory: Int?
    var vendor: String
    var productType: String
    var tags: [String]
    
    @Relationship(deleteRule: .cascade)
    var variants: [ProductVariant] = []
    
    @Relationship(deleteRule: .cascade)
    var options: [ProductOption] = []
    
    @Relationship(deleteRule: .cascade)
    var featuredImage: ProductImage?
    
    init(availableForSale: Bool,
         productDescription: String,
         id: String,
         isGiftCard: Bool,
         title: String,
         totalInventory: Int?,
         vendor: String,
         productType: String,
         tags: [String]) {
        self.availableForSale = availableForSale
        self.productDescription = productDescription
        self.id = id
        self.isGiftCard = isGiftCard
        self.title = title
        self.totalInventory = totalInventory
        self.vendor = vendor
        self.productType = productType
        self.tags = tags
    }
}

@Model
class ProductVariant {
    var id: String
    var currentlyNotInStock: Bool
    
    @Relationship(deleteRule: .cascade)
    var price: ProductPrice?
    
    @Relationship(inverse: \ShopifyProduct.variants)
    var product: ShopifyProduct?
    
    init(id: String,
         currentlyNotInStock: Bool,
         price: ProductPrice? = nil) {
        self.id = id
        self.currentlyNotInStock = currentlyNotInStock
        self.price = price
    }
}

@Model
class ProductPrice {
    var amount: Double
    var currencyCode: String
    
    @Relationship(inverse: \ProductVariant.price)
    var variant: ProductVariant?
    
    init(amount: Double, currencyCode: String) {
        self.amount = amount
        self.currencyCode = currencyCode
    }
}

@Model
class ProductOption {
    var id: String
    var name: String
    
    @Relationship(deleteRule: .cascade)
    var values: [OptionValue] = []
    
    @Relationship(inverse: \ShopifyProduct.options)
    var product: ShopifyProduct?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

@Model
class OptionValue {
    var id: String
    var name: String
    
    @Relationship(inverse: \ProductOption.values)
    var option: ProductOption?
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

@Model
class ProductImage {
    var url: String
    
    @Relationship(inverse: \ShopifyProduct.featuredImage)
    var product: ShopifyProduct?
    
    init(url: String) {
        self.url = url
    }
}
