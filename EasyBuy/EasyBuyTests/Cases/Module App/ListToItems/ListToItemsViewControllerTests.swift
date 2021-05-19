//
//  ListToItemsViewControllerTests.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 16/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//
//
@testable import EasyBuy
import XCTest

class ListToItemsViewControllerTests: XCTestCase{
    // MARK: Subject under test
    
    var sut: ListToItemsViewController!
    var spy: ListToItemsBusinessLogicSpy!
    var window: UIWindow!
    var presenter: ListToItemsPresenter!
    var interactorAccessMetod:ListToItemsInteractor!
    var viewModelGetCategorie: ListToItems.GetCategorie.ViewModel!
    var viewModelLoadInitalData: ListToItems.LoadInitalData.ViewModel!
    var viewModelGetItemForName: ListToItems.GetItemForName.ViewModel!
    
    // MARK: Test lifecycle
    
    override func setUp(){
        super.setUp()
        window = UIWindow()
        setupListToItemsViewController()
    }
    
    override func tearDown(){
        window = nil
        sut = nil
        spy = nil
        presenter = nil
        interactorAccessMetod = nil
        viewModelGetCategorie = nil
        viewModelLoadInitalData = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupListToItemsViewController(){
        sut = ListToItemsViewController()
        spy = ListToItemsBusinessLogicSpy()
        sut.interactor = spy
        presenter = ListToItemsPresenter()
        interactorAccessMetod = ListToItemsInteractor()
        viewModelLoadInitalData = ListToItems.LoadInitalData.ViewModel(caregories: Seeds.items.resulstCategories)
    }
    
    func loadView(){
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    
    // MARK: Test doubles
    
    class ListToItemsBusinessLogicSpy: ListToItemsBusinessLogic{
    
        var LoadInitalDataCalled = false
        var getCategoreInformation = false
        var getNextPageItemInformation = false
        var getItemForNameInformation = false
        var getNextItemForNameInformation = false
        
        func loadInitialInformation(request: ListToItems.LoadInitalData.Request){
            LoadInitalDataCalled = true
        }
        
        func getCategoreInformation(request: ListToItems.GetCategorie.Request) {
            getCategoreInformation = true
        }
        
        func getNextPageItemInformation(request: ListToItems.GetCategorie.Request) {
            getNextPageItemInformation = true
        }
        
        func getItemForNameInformation(request: ListToItems.GetItemForName.Request) {
            getItemForNameInformation = true
        }
        
        func getNextItemForNameInformation(request: ListToItems.GetItemForName.Request) {
            getNextItemForNameInformation = true
        }
    }
    
    
    func getResultItems() -> [ItemModel] {
        let itemsCodable = interactorAccessMetod.returnItemCodable(items: (Seeds.items.resustItemsResults?.items)!)
        return presenter.getItemsModel(itemsCodable: itemsCodable)
    }
    
    
    func getGetCategorie(){
        let items: [ItemModel] = getResultItems()
        viewModelGetCategorie = ListToItems.GetCategorie.ViewModel(items: items, areThereMoreItems: true)
    }
    
    func getGetItemForName(){
        let items: [ItemModel] = getResultItems()
        viewModelGetItemForName = ListToItems.GetItemForName.ViewModel(items: items, areThereMoreItems: true)
    }
    
    // MARK: Tests
    
    func test_ShouldLoadInitialInformationWhenViewIsLoaded(){
        // Given
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.LoadInitalDataCalled, "viewDidLoad() should ask the interactor to do something")
    }
    
    func test_giveDisplayLoadInitialInformation_whenSuccess(){
        // When
        loadView()
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        let cell = sut.categoriesColllection.dataSource?.collectionView(sut.categoriesColllection, cellForItemAt: IndexPath(row: 0, section: 0)) as! CategoriesCollectionViewCell
        // Then
        XCTAssertEqual(cell.textCategorie.text, "Accesorios para Vehículos", "displayInitialInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveDisplayCategoreInformation_whenSuccess(){
        // Given
        getGetCategorie()
        // When
        loadView()
        sut.displayCategoreInformation(viewModel: viewModelGetCategorie)
        
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        // Then
        XCTAssertEqual(cell.nameItem.text, "Rodamiento Balinera 6000 2rs 10x26x8mm Zsg", "displayCategoreInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveDisplayInitialInformationError_whenSuccess(){
        // Given
        let messageError = NSLocalizedString("listToItems.label.errorCategorias", comment: "")
        let viewModel =  ListToItems.ErrorCategorias.ViewModel(messageErrorCategories: messageError)
        
        // When
        loadView()
        sut.displayInitialInformationError(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.dontCategoriesLabel.text, messageError,"displayInitialInformationError(viewModel:) should update the name text field")
    }
    
    
    func test_giveGetCategoreInformation_whenSuccess(){
        loadView()
        // When
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        
        sut.categoriesColllection.delegate?.collectionView?(sut.categoriesColllection, didSelectItemAt: IndexPath(item: 0, section: 0))
        // Then
        XCTAssertTrue(spy.getCategoreInformation, "getCategoreInformation(viewModel:) should update the name text field")
    }
    
    
    
    func test_giveGetNextPageItem_whenSuccess(){
        loadView()
        //Give
        getGetCategorie()
        sut.displayInitialInformation(viewModel: viewModelLoadInitalData)
        sut.displayCategoreInformation(viewModel: viewModelGetCategorie)
        
        sut.categoriesColllection.delegate?.collectionView?(sut.categoriesColllection, didSelectItemAt: IndexPath(item: 0, section: 0))
        // When
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        sut.listItemsTable.delegate?.tableView?(sut.listItemsTable, willDisplay: cell, forRowAt: IndexPath(row: 47, section: 0))
        // Then
        XCTAssertTrue(spy.getNextPageItemInformation, "getCategoreInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveDisplayNextPageItemInformation_whenSuccess(){
        loadView()
        
        getGetCategorie()
        // When
    
        sut.displayNextPageItemInformation(viewModel: viewModelGetCategorie)
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        // Then
        XCTAssertEqual(cell.nameItem.text, "Rodamiento Balinera 6000 2rs 10x26x8mm Zsg", "displayNextPageItemInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveShearchItemBarShearch_whenSuccess(){
        loadView()
        
        getGetCategorie()
        // When
        sut.shearchItemBar.text = "Controles"
        sut.shearchItemBar.delegate?.searchBarSearchButtonClicked?(sut.shearchItemBar)
        // Then
        XCTAssertTrue(spy.getItemForNameInformation, "getItemForNameInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveDisplaygetItemForNameInformation_whenSuccess(){
        loadView()
        getGetItemForName()
        // When
        sut.displaygetItemForNameInformation(viewModel: viewModelGetItemForName)
        // Then
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        // Then
        XCTAssertEqual(cell.nameItem.text, "Rodamiento Balinera 6000 2rs 10x26x8mm Zsg", "displaygetItemForNameInformation(viewModel:) should update the name text field")
    }
    
    func test_giveDisplayNextItemForNameInformation_whenSuccess(){
        loadView()
        getGetItemForName()
        // When
        sut.displayNextItemForNameInformation(viewModel: viewModelGetItemForName)
        // Then
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        // Then
        XCTAssertEqual(cell.nameItem.text, "Rodamiento Balinera 6000 2rs 10x26x8mm Zsg", "displayNextItemForNameInformation(viewModel:) should update the name text field")
    }
    
    
    func test_giveGetNextPageItemNextItemForName_whenSuccess(){
        loadView()
        getGetItemForName()
        // When
        sut.displayNextItemForNameInformation(viewModel: viewModelGetItemForName)
        // When
        let cell = sut.listItemsTable.dataSource?.tableView(sut.listItemsTable, cellForRowAt: IndexPath(row: 0, section: 0)) as! ItemTableViewCell
        sut.listItemsTable.delegate?.tableView?(sut.listItemsTable, willDisplay: cell, forRowAt: IndexPath(row: 47, section: 0))
        // Then
        XCTAssertTrue(spy.getNextItemForNameInformation, "GetNextPageItemNextItemForName(viewModel:) should update the name text field")
    }

    
    func test_giveDisplayErroItemInformation_whenSuccess(){
        loadView()
        let viewModel = ServiceError.ErrorGeneral.ViewModel(errorMesage: CustomErrors.errorGeneralResponse.getErrorMessage(), error: CustomErrors.errorGeneralResponse)
        // When
        sut.displayErroItemInformation(viewModel:viewModel)
        // Then
        guard let alertViewController = sut.presentedViewController as? AlertViewController else{XCTFail("Invalid alertViewController"); return}
        // Then
        XCTAssertEqual(alertViewController.textAlert, NSLocalizedString("service.error.errorGeneralResponse",
                                                                        comment: ""), "displayErroItemInformation(viewModel:) should update the name text field")
    }
    
    
    
    
    
    
    
}
