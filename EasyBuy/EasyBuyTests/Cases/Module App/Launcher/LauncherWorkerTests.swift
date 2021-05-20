//
//  LauncherWorkerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//
//

@testable import EasyBuy
import XCTest

class LauncherWorkerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: LauncherWorker!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        setupLauncherWorker()
    }
    
    override func tearDown(){
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupLauncherWorker(){
        sut = LauncherWorker()
    }
    
    // MARK: Test doubles
    
    // MARK: Tests
    
    func testSomething(){
        // Given
        sut.doSomeWork()
        // When
        
        // Then
    }
}
