import Foundation
import MobileBuySDK


final class ProductDetailsViewModel:ObservableObject{
    
    @Published var productDetails : Storefront.Product? = nil
    private let productDetailsCase : ProductDetailsUsecaseProtocol
    private let saveToFirestoreCase : SaveToFirestoreUseCaseProtocol
    private let cartUseCase : CartUsecaseProtocol
    @Published var isInCart = false
    var addedLineId: String?
    
    init(productDetailsCase: ProductDetailsUsecaseProtocol, saveToFirestoreCase: SaveToFirestoreUseCaseProtocol, cartUseCase : CartUsecaseProtocol) {
        self.productDetailsCase = productDetailsCase
        self.saveToFirestoreCase = saveToFirestoreCase
        self.cartUseCase = cartUseCase
    }
    
    func getProductDetails(id: GraphQL.ID){
        productDetailsCase.getProductDetails(id: id) { result in
            switch result{
            case .success(let productDetails) :
                self.productDetails = productDetails
            case .failure(let error) :
                print("Error \(error)")
            }
        }
    }
    
    func saveShopifyProduct(_ item: Storefront.Product) {
    
        let firestoreProduct = FirestoreShopifyProduct(
            id: item.id.rawValue,
            title: item.title,
            brand: item.vendor,
            price: "\(item.variants.nodes.first?.price.amount ?? 0.00)",
            imageUrl: item.featuredImage?.url.absoluteString ?? "",
            currencyName: item.variants.nodes.first?.price.currencyCode.rawValue ?? "egp"
        )
        
        saveToFirestore(firestoreProduct)
    }
    
    private func saveToFirestore(_ product: FirestoreShopifyProduct){
        saveToFirestoreCase.execute(product: product)
    }
    
    func getMatchingVariant(selectedSize: String, selectedColor: String) -> Storefront.ProductVariant? {
        guard let variants = productDetails?.variants.nodes else { return nil }

        for variant in variants {
            let options = variant.selectedOptions
            let sizeMatch = options.first { $0.name.lowercased() == "size" && $0.value == selectedSize }
            let colorMatch = options.first { $0.name.lowercased() == "color" && $0.value == selectedColor }

            if sizeMatch != nil && colorMatch != nil {
                return variant
            }
        }
        return nil
    }
    
    func addToCart(variantId: String, quantity: Int) {
        cartUseCase.addToCart(variantId: variantId, quantity: quantity) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    print("Added to cart: \(cart.id.rawValue)")
                    if let line = cart.lines.edges.first?.node {
                        self.addedLineId = line.id.rawValue
                    }
                    self.isInCart = true
                case .failure(let error):
                    print("Failed to add to cart: \(error.localizedDescription)")
                }
            }
        }
    }

    func removeFromCart() {
        guard let lineId = addedLineId else {
            return
        }
        cartUseCase.removeFromCart(lineId: lineId) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let cart):
                    print("Removed from cart: \(cart.id.rawValue)")
                    self.isInCart = false
                    self.addedLineId = nil
                case .failure(let error):
                    print("Failed to remove from cart: \(error.localizedDescription)")
                }
            }
        }
    }
}
