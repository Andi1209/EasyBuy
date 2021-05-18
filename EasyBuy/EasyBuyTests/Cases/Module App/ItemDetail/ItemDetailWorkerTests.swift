//
//  ItemDetailWorkerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupItemDetailWorker()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailWorker(){
        sut = ItemDetailWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething(){
        // Given
        
        // When
        
        // Then
    }
}
