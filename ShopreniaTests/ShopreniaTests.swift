@testable import Shoprenia
import XCTest
import MobileBuySDK


final class ShopreniaTests: XCTestCase {

    var productDetailsService: ProductDetailsServiceProtocol!
    var firestoreservice: FireStoreServicesProtocol!
    var customerService: CustomerServicesProtocol!
    var firebaseService: FirebaseManagerProtocol!
    var googleService : GoogleAuthenticationServicesProtocol!
    
    override func setUpWithError() throws {
        productDetailsService = ProductDetailsService()
        firestoreservice = FireStoreServices()
        customerService = CustomerServices()
        firebaseService = FirebaseAuthenticationManager.shared
        googleService = GoogleAuthenticationServices.shared
    }

    override func tearDownWithError() throws {
       productDetailsService = nil
       firestoreservice = nil
        customerService = nil
        firebaseService = nil
        googleService = nil
    }
    
    func testFetchProductDetails(){
        
        let expectation = expectation(description: "Awaiting response...")
        
        productDetailsService?.fetchProductDetails(id: GraphQL.ID(rawValue: "gid://shopify/Product/7944168734794")){result in
            switch result {
            case .success(let product):
                print("in here")
                XCTAssertNotNil(product)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testFetchWishlistFirestore(){
        let expectation = expectation(description: "Awaiting response...")
        
        firestoreservice.fetchWishlistFirestore { result in
            switch result {
                
            case .success(let wishlist):
                XCTAssertNotNil(wishlist)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")
            }
        }
        waitForExpectations(timeout: 10)
    }
    
    func testCreateCustomer(){
        let expectation = expectation(description: "Awaiting response...")
        
        customerService.createCustomer(email: "nxxeylkebvdbmytugj@nespf.com", password: "Ihf1608155@1", firstName: "Unittt", lastName: "Testtt", phone:"+201090986438"){result in
            switch result {
                case .success(let customer):
                XCTAssertNotNil(customer)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")}
        }
        waitForExpectations(timeout: 20)
    }
    
    func testCreateCustomerWithoutPhone(){
        
        let expectation = expectation(description: "Awaiting response...")
        
        customerService.createCustomerWithoutPhone(email: "nxxeylkebvdbjytxgj@nespf.com", password: "Ihf1608155@1", firstName: "Unittttes", lastName: "Testto"){result in
            switch result {
                case .success(let customer):
                XCTAssertNotNil(customer)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")}
        }
        waitForExpectations(timeout: 20)
    }
    
    func testCreateCustomerAccessToken(){
        let expectation = expectation(description: "Awaiting response...")
        
        customerService.createCustomerAccessToken(email: "nxxeylkebvdbmytugj@nespf.com", password: "Ihf1608155@1") { result in
            
            switch result {
                case .success(let accessToken):
                XCTAssertNotNil(accessToken)
                expectation.fulfill()
            case .failure(let error):
                XCTFail("\(error)")}
            
        }
        waitForExpectations(timeout: 20)
    }
    
    func testCreateFirebaseUser(){
        let expectation = expectation(description: "Awaiting response...")
        
        firebaseService.createFirebaseUser(email: "nzxeylzebvdbmytxgj@nespf.com", password: "Ihf1608155@1", firstname: "Unittttts", lastname: "Testttts") { isRegistered in
            
           XCTAssertTrue(isRegistered)
            expectation.fulfill()
            
        }
        
        waitForExpectations(timeout: 10)
    }
    
    
    
    
}

        
        
