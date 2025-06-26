
import XCTest
@testable import Shoprenia
import MobileBuySDK

final class ProductDetailsViewModelTest: XCTestCase {
    var viewModel: ProductDetailsViewModel!
    var mockDetailsUseCase: MockProductDetailsUseCase!
    var mockSaveUseCase: MockSaveToFirestoreUseCase!
    var mockCartUseCase: MockCartUseCase!
    
    override func setUp() {
        super.setUp()
        mockDetailsUseCase = MockProductDetailsUseCase()
        mockSaveUseCase = MockSaveToFirestoreUseCase()
        mockCartUseCase = MockCartUseCase()
        viewModel = ProductDetailsViewModel(
            productDetailsCase: mockDetailsUseCase,
            saveToFirestoreCase: mockSaveUseCase,
            cartUseCase: mockCartUseCase
        )
    }
    
    func testGetProductDetailsUpdatesPublishedValue() {
        let dummyProduct = Storefront.Product(rawValue: [
            "id": "1",
            "title": "Test Product",
            "productType": "Shirt",
            "vendor": "MockVendor"
        ])
        mockDetailsUseCase.productToReturn = dummyProduct
        
        viewModel.getProductDetails(id: .init(rawValue: "123"))
        
        XCTAssertEqual(viewModel.productDetails?.title, "Test Product")
    }
    
    func testGetMatchingVariantReturnsCorrectVariant() {
        let productRaw: [String: Any] = [
            "id": "gid://shopify/Product/123",
            "title": "Test Product",
            "vendor": "MockVendor",
            "variants": [
                "nodes": [
                    [
                        "id": "gid://shopify/ProductVariant/111",
                        "price": [
                            "amount": "100.00",
                            "currencyCode": "EGP"
                        ],
                        "selectedOptions": [
                            ["name": "Size", "value": "M"],
                            ["name": "Color", "value": "Red"]
                        ]
                    ],
                    [
                        "id": "gid://shopify/ProductVariant/222",
                        "price": [
                            "amount": "120.00",
                            "currencyCode": "EGP"
                        ],
                        "selectedOptions": [
                            ["name": "Size", "value": "L"],
                            ["name": "Color", "value": "Blue"]
                        ]
                    ]
                ]
            ]
        ]

        let dummyProduct = Storefront.Product(rawValue: productRaw)
        viewModel.productDetails = dummyProduct

        let matchedVariant = viewModel.getMatchingVariant(selectedSize: "M", selectedColor: "Red")
        XCTAssertEqual(matchedVariant?.id.rawValue, "gid://shopify/ProductVariant/111")
    }

}
