
import XCTest
@testable import Shoprenia

final class AuthenticationViewModelTests: XCTestCase {
    
    var mockUserDefaults: MockUserDefaultsManager!
    var viewModel: AuthenticationViewModel!
    override func setUpWithError() throws {
        mockUserDefaults = MockUserDefaultsManager()
        viewModel = AuthenticationViewModel(userDefaults: mockUserDefaults)
        
    }
    
    override func tearDownWithError() throws {
        mockUserDefaults = nil
        viewModel = nil
        
    }
    
    func testGetAccessTokenReturnsToken() {
        mockUserDefaults.accessToken = "fake_token_123"
        let token = viewModel.getAccessToken()
        XCTAssertEqual(token, "fake_token_123")
    }
    
    
    
    func testIsAuthenticatedFunctionReturnsTrueWhenTokenExists() {
        mockUserDefaults.accessToken = "token"
        XCTAssertTrue(viewModel.isAuthenticated())
    }
    
    func testIsAuthenticatedFunctionReturnsFalseWhenTokenIsNil() {
        mockUserDefaults.accessToken = nil
        XCTAssertFalse(viewModel.isAuthenticated())
    }
    
    func testGetUserNameReturnsCorrectName() {
        
        mockUserDefaults.displayName = "User"
        
        
        let name = viewModel.getUserName()
        
        
        XCTAssertEqual(name, "User")
    }
    
    
}
