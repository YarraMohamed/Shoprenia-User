import Foundation
import MobileBuySDK


final class ProductDetailsViewModel:ObservableObject{
    
    @Published var productDetails : Storefront.Product? = nil
    private let productDetailsCase : GetProductDetailsUseCase
    private let cartUseCase : CartUsecase
    @Published var isInCart = false
    var addedLineId: String?
    
    init(productDetailsCase: GetProductDetailsUseCase, cartUseCase : CartUsecase ) {
        self.productDetailsCase = productDetailsCase
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
