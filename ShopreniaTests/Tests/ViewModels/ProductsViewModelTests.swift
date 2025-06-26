
import XCTest
@testable import Shoprenia
import MobileBuySDK

final class ProductsViewModelTests: XCTestCase {
    var viewModel: ProductsViewModel!
    var mockRepo: MockProductsRepo!
    var mockUseCase: GetProducts!
    
    override func setUp() {
        super.setUp()
        mockRepo = MockProductsRepo()
        mockUseCase = GetProducts(repository: mockRepo)
        viewModel = ProductsViewModel(fetchProductsUseCase:mockUseCase )
    }
    
    func createMockProduct(id: String, title: String, price: Decimal) -> Storefront.Product {
        return Storefront.Product(rawValue: [
            "id": "gid://shopify/Product/\(id)",
            "title": title,
            "vendor": "TestVendor",
            "variants": [
                "nodes": [
                    [
                        "id": "gid://shopify/ProductVariant/\(id)-variant",
                        "price": [
                            "amount": "\(price)",
                            "currencyCode": "EGP"
                        ],
                        "selectedOptions": []
                    ]
                ]
            ]
        ])!
    }
    
    func testLoadAllProducts_Success_ShouldUpdateProductsArray() {
        // Arrange
        let dummyProducts = [
            createMockProduct(id: "1", title: "Sneakers", price: 150)
        ]
        mockRepo.resultToReturn = .success(dummyProducts)
        
        let expectation = XCTestExpectation(description: "Products loaded")
        
        // Act
        viewModel.loadAllProducts()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Assert
            XCTAssertEqual(self.viewModel.products.count, 1)
            XCTAssertEqual(self.viewModel.products.first?.title, "Sneakers")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testLoadVendorProducts_Success_ShouldUpdateProductsArray() {
        let dummyProducts = [
            createMockProduct(id: "2", title: "T-Shirt", price: 120)
        ]
        mockRepo.resultToReturn = .success(dummyProducts)
        
        let expectation = XCTestExpectation(description: "Vendor products loaded")
        viewModel.loadVendorProducts(vendor: "Nike")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            XCTAssertEqual(self.viewModel.products.count, 1)
            XCTAssertEqual(self.viewModel.products.first?.title, "T-Shirt")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testFilterProducts_WhenSliderValueApplied_ShouldFilterAccordingly() {
        let lowPrice = createMockProduct(id: "1", title: "Cheap Shoes", price: 50)
        let highPrice = createMockProduct(id: "2", title: "Expensive Jacket", price: 200)
        
        viewModel.products = [lowPrice, highPrice]
        viewModel.sliderValue = 100.0
        
        viewModel.filterProducts()
        
        XCTAssertEqual(viewModel.filteredProducts.count, 1)
        XCTAssertEqual(viewModel.filteredProducts.first?.title, "Expensive Jacket")
    }
    
    func testSearchText_WhenMatches_ShouldReturnFilteredList() {
        let p1 = createMockProduct(id: "1", title: "Jacket", price: 150)
        let p2 = createMockProduct(id: "2", title: "Socks", price: 30)
        
        viewModel.products = [p1, p2]
        viewModel.searchText = "jacket"
        
        let expectation = XCTestExpectation(description: "Search filtered")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            XCTAssertEqual(self.viewModel.searchedProducts.count, 1)
            XCTAssertEqual(self.viewModel.searchedProducts.first?.title.lowercased(), "jacket")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
    
    func testSearchText_Empty_ShouldRestoreFullList() {
        let p = createMockProduct(id: "3", title: "Shorts", price: 80)
        viewModel.products = [p]
        
        viewModel.searchText = ""
        
        let expectation = XCTestExpectation(description: "Search restored")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
            XCTAssertEqual(self.viewModel.searchedProducts.count, 1)
            XCTAssertEqual(self.viewModel.searchedProducts.first?.title, "Shorts")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 1)
    }
}
