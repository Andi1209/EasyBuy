//
//  ItemDetailViewControllerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//
//

@testable import EasyBuy
import XCTest

class ItemDetailViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ItemDetailViewController!
    var window: UIWindow!
    var spy: ItemDetailBusinessLogicSpy!
    var item: ItemModel!
    var viewModelLoadInitalData: ItemDetail.LoadInitalData.ViewModel!
   
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupItemDetailViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        XCUIDevice.shared.orientation = UIDeviceOrientation.portrait;
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupItemDetailViewController(){
        sut = ItemDetailViewController()
        spy = ItemDetailBusinessLogicSpy()
        sut.interactor = spy
        item = ItemModelMock().initMock()
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    // MARK: Test doubles
    
    class ItemDetailBusinessLogicSpy: ItemDetailBusinessLogic{
        var LoadInitalDataCalled = false
        
        func loadInitialInformation(request: ItemDetail.LoadInitalData.Request){
            LoadInitalDataCalled = true
        }
    }
    
    
    func getLoadInitalData(){
        let headerSellerInformation = NSLocalizedString("itemDetail.label.headerSellerInformation", comment: "")
        let headerFeatureInformation = NSLocalizedString("itemDetail.label.headerFeatureInformation", comment: "")
        viewModelLoadInitalData = ItemDetail.LoadInitalData.ViewModel(item: item, headerSellerInformation: headerSellerInformation, headerFeatureInformation: headerFeatureInformation)
    }
    
    // MARK: Tests
    
    func test_giveShouldLoadInitialInformationWhenViewIsLoaded_whenSuccess(){
        // Given
        loadView()
        // When
        sut.loadInitialInformation()
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func test_displayInitialInformation_whenSucces(){
        // Given
        loadView()
        getLoadInitalData()
        
        // When
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        guard let cell = sut.tableDetailItem.dataSource?.tableView(sut.tableDetailItem, cellForRowAt: IndexPath(row: 0, section: 0)) as? InformationItemTableViewCell else{XCTFail("Invalid alertViewController"); return}
        
        // Then
        XCTAssertEqual(cell.nameItem.text, "Pijama Para Carro En Algodón Impermeable Talla L", "viewDidLoad() should ask the interactor to do something")
    }
    
    func test_displayInitialInformationLandScape_whenSucces(){
        // Given
        loadView()
        getLoadInitalData()
        // When
        XCUIDevice.shared.orientation = UIDeviceOrientation.landscapeRight;
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        guard let cell = sut.tableDetailItem.dataSource?.tableView(sut.tableDetailItem, cellForRowAt: IndexPath(row: 0, section: 0)) as? InformationItemTableViewCell else{XCTFail("Invalid alertViewController"); return}
        
        // Then
        XCTAssertEqual(cell.nameItem.text, "Pijama Para Carro En Algodón Impermeable Talla L", "viewDidLoad() should ask the interactor to do something")
    }
    
    
    func test_displayInitialInformationHeaderInformation_whenSucces(){
        // Given
        loadView()
        getLoadInitalData()
        
        // When
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        guard let cell = sut.tableDetailItem.dataSource?.tableView(sut.tableDetailItem, cellForRowAt: IndexPath(row: 1, section: 0)) as? HeaderInformationItemTableViewCell else{XCTFail("Invalid alertViewController"); return}
        
        // Then
        XCTAssertEqual(cell.title.text, NSLocalizedString("itemDetail.label.headerSellerInformation", comment: ""), "test_displayInitialInformationHeaderInformation_whenSucces should ask the interactor to do something")
    }
    
    func test_displayInitialInformationOnlyText_whenSucces(){
        // Given
        loadView()
        getLoadInitalData()
        
        // When
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        guard let cell = sut.tableDetailItem.dataSource?.tableView(sut.tableDetailItem, cellForRowAt: IndexPath(row: 2, section: 0)) as? OnlyTextInformationTableViewCell else{XCTFail("Invalid alertViewController"); return}
        
        // Then
        XCTAssertEqual(cell.value.text, "Barrios Unidos - Bogotá D.C.", "test_displayInitialInformationTwoRow_whenSucces should ask the interactor to do something")
    }
    
    func test_displayInitialInformationTwoText_whenSucces(){
        // Given
        loadView()
        getLoadInitalData()
        
        // When
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        guard let cell = sut.tableDetailItem.dataSource?.tableView(sut.tableDetailItem, cellForRowAt: IndexPath(row: 4, section: 0)) as? TwoTextInformationTableViewCell else{XCTFail("Invalid alertViewController"); return}
        
        // Then
        XCTAssertEqual(cell.subTitle.text, "Marca", "test_displayInitialInformationTwoText_whenSucces should ask the interactor to do something")
    }
    
}
