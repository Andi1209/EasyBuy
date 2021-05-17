//
//  NetworkManagerTest.swift
//  EasyBuyTests
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

@testable import EasyBuy
import XCTest

class NetworkManagerTest: XCTestCase {

    var networkEngineSpy:BasicNetworkEngineTest!
    var mockSession: MockURLSession!
    var expectation: XCTestExpectation!
    var error:Int?
    var newLogin: [Categorie]!
    var responseDecodable:Decodable!
    var uRLRequest: URLRequestConvertible!
    var uRLSearchItemCat: URLRequestConvertible!
    
    override func setUp() {
      super.setUp()
        mockSession = MockURLSession()
        networkEngineSpy = BasicNetworkEngineTest(session: mockSession, responseQueue: nil)
        networkEngineSpy.nameMockArchive =  "Categories"
        expectation = self.expectation(description: "Completion wasn't called")
        NetworkManager.networkEngine = networkEngineSpy
        uRLRequest = APIRouter.categories(country: "MCO")
        uRLSearchItemCat = APIRouter.searchItemCat(country: "MCO", category: "MCO1747", offset: "0")
        
    }
    
    override func tearDown() {
        mockSession = nil
        networkEngineSpy = nil
        networkEngineSpy = nil
        expectation = nil
        error = nil
        newLogin = nil
        NetworkManager.dataTask = nil
      super.tearDown()
    }
    
    // MARK: GIVE
    
    func whenToRequest(uRLRequestConvertible: URLRequestConvertible){
        NetworkManager.requestBasicWithURLConvertible(uRLRequestConvertible: uRLRequestConvertible) { (response, result) in
            switch result{
            case .success(let defautCodable):
                self.responseDecodable = defautCodable as? Decodable
                self.expectation.fulfill()
            case .failure(let error):
                self.responseDecodable = nil
                self.error = error?.code
                self.expectation.fulfill()
                
            }
        }
    }
    
    
    func test_categories_succes() {
        // When
        whenToRequest(uRLRequestConvertible: uRLRequest)

        // Then
        wait(for: [expectation], timeout: 4)
        XCTAssertNotNil(self.responseDecodable,"NetworkManager.requestBasicWithURLConvertible error call")
    }
    
    func test_categories_error() {
        // Give
        networkEngineSpy.response = HTTPURLResponse(url: networkEngineSpy.getUrl,
                                                    statusCode: 404,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        
        // When
        whenToRequest(uRLRequestConvertible: uRLRequest)

        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNil(self.responseDecodable,"NetworkManager.requestBasicWithURLConvertible error dont ejecture")
        XCTAssertEqual(self.error, CustomErrors.errorGeneralResponse.code)
    }
    
    func test_categories_serviceError() {
        // Give
        networkEngineSpy.response = HTTPURLResponse(url: networkEngineSpy.getUrl,
                                                    statusCode: 500,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        
        // When
        whenToRequest(uRLRequestConvertible: uRLRequest)

        // Then
        wait(for: [expectation], timeout: 3)
        XCTAssertNil(self.responseDecodable,"NetworkManager.requestBasicWithURLConvertible error in serice ")
        XCTAssertEqual(self.error, CustomErrors.errorGeneralResponse.code)
    }
    
    func test_searchItemCat_succes() {
        // When
        networkEngineSpy.response = HTTPURLResponse(url: networkEngineSpy.getUrlShearCategoria,
                                                    statusCode: 200,
                                                    httpVersion: nil,
                                                    headerFields: nil)
        
        whenToRequest(uRLRequestConvertible: uRLSearchItemCat)

        // Then
        wait(for: [expectation], timeout: 4)
        XCTAssertNotNil(self.responseDecodable,"NetworkManager.requestBasicWithURLConvertible error call")
    }
    
    

}

