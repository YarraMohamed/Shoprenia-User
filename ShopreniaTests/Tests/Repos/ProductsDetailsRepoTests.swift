import XCTest
@testable import Shoprenia
import MobileBuySDK

final class ProductDetailsRepositoryTests: XCTestCase {
    
    var mockService: MockProductDetailsService!
    var repository: ProductDetailsRepository!
    
    override func setUp() {
        super.setUp()
        mockService = MockProductDetailsService()
        repository = ProductDetailsRepository(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        repository = nil
        super.tearDown()
    }

    func testFetchProductDetailsSuccess() {
        let mockProduct = Storefront.Product(rawValue: [
            "id": "product_1",
            "title": "Test Product",
            "vendor": "Nike"
        ])
        mockService.mockProduct = mockProduct
        
        let expectation = self.expectation(description: "Fetching product details")

        repository.fetchProductDetails(id: GraphQL.ID(rawValue:"12345")) { result in
            switch result {
            case .success(let product):
                XCTAssertEqual(product.title, "Test Product")
            case .failure:
                XCTFail("Expected success but got failure")
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        XCTAssertTrue(mockService.fetchCalled)
    }

    func testFetchProductDetailsFailure() {
        mockService.shouldReturnError = true
        
        let expectation = self.expectation(description: "Fetching product details with error")

        repository.fetchProductDetails(id: GraphQL.ID(rawValue:"12345")) { result in
            switch result {
            case .success:
                XCTFail("Expected failure but got success")
            case .failure(let error):
                XCTAssertNotNil(error)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1)
        XCTAssertTrue(mockService.fetchCalled)
    }

    func testSaveToFirestore() {
        let dummyProduct = FirestoreShopifyProduct(id: "1", title: "TEST", brand: "brand", price:"12.0", imageUrl: "Url", currencyName: "Egp")

        repository.saveToFirestore(product: dummyProduct)
        
        XCTAssertTrue(mockService.saveCalled)
    }
}
