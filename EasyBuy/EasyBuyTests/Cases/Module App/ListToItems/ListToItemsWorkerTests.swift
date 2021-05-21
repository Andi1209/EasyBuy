//
//  ListToItemsWorkerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//
//

@testable import EasyBuy
import XCTest

class ListToItemsWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListToItemsWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupListToItemsWorker()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListToItemsWorker(){
        sut = ListToItemsWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func test_giveFetchCategories_whenSuccess(){
        // Given
        let exp = expectation(description: "Success categorry")
        var statusCode:Int?
        var searchResult:Result<[Categorie]>?
        // When
        sut.fetchCategories(country: "MCO") { (response, result) in
            searchResult = result
            statusCode = response.statusCode
            exp.fulfill()
        }
        // Then
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResult!.isSuccess)
    }
    
    
    func test_giveFetchCategorieForID_whenSuccess(){
        // Given
        let exp = expectation(description: "Success")
        var statusCode:Int?
        var searchResult:Result<ItemsResult>?
        // When
        sut.fetchCategorieForID(country: "MCO", category: "MCO1747", offset: "0") { (response, result) in
            searchResult = result
            statusCode = response.statusCode
            exp.fulfill()
        }
        // Then
        wait(for: [exp], timeout: 30)
        XCTAssertEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResult!.isSuccess)
    }
    
    
    func test_giveFetchItemForName_whenSuccess(){
        // Given
        let exp = expectation(description: "Success")
        var statusCode:Int?
        var searchResult:Result<ItemsResult>?
        // When
        sut.fetchItemForName(country: "MCO", name: "Cintas", offset: "0") { (response, result) in
            searchResult = result
            statusCode = response.statusCode
            exp.fulfill()
        }
        // Then
        wait(for: [exp], timeout: 5)
        XCTAssertEqual(statusCode, 200, "the request or service is not rigth")
        XCTAssertTrue(searchResult!.isSuccess)
    }
    
    
    
    
    
}
