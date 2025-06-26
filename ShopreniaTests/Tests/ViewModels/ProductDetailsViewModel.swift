
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
}
