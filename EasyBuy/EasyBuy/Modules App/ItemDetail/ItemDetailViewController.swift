//
//  ItemDetailViewController.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol ItemDetailDisplayLogic: class {
    func displayInitialInformation(viewModel: ItemDetail.LoadInitalData.ViewModel)
}

class ItemDetailViewController: BaseViewController, ItemDetailDisplayLogic {
    var interactor: ItemDetailBusinessLogic?
    var router: (NSObjectProtocol & ItemDetailRoutingLogic & ItemDetailDataPassing)?
    // MARK: Outlets
    @IBOutlet weak var tableDetailItem: UITableView!
    
    
    // MARK: var-let
    private let tableItemDetail = TableItemDetail()
    private var isLandscape:Bool = UIDevice.current.orientation.isLandscape
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    init() {
        let className = NSStringFromClass(ItemDetailViewController.self).split(separator: ".")
        if className.count > 1{
            super.init(nibName: "\(className[1])", bundle: nil)
            setup()
        }else{
            super.init()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
        print("ItemDetailViewController + deinit")
    }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ItemDetailInteractor()
        let presenter = ItemDetailPresenter()
        let router = ItemDetailRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setTitleLabelNavigationBar(title:  NSLocalizedString("barTitle.label.itemdetail", comment: ""), colortext: UIColor.black)
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillTransitionToSize), name: UIDevice.orientationDidChangeNotification, object: nil)
        loadInitialInformation()
    }
    
    
    @objc func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.height == 0.0 {
            if UIDevice.current.orientation.isLandscape  {
                isLandscape = true
            } else {
                isLandscape = false
            }
            tableItemDetail.isLandscape = isLandscape
            tableDetailItem.reloadData()
        }
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = ItemDetail.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: ItemDetail.LoadInitalData.ViewModel) {
        tableItemDetail.isLandscape = false
        tableItemDetail.item = viewModel.item
        tableItemDetail.headerSellerInformation = viewModel.headerSellerInformation
        tableItemDetail.headerFeatureInformation = viewModel.headerFeatureInformation
        tableDetailItem.register(UINib(nibName: InformationItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: InformationItemTableViewCell.identifier)
        tableDetailItem.register(UINib(nibName: HeaderInformationItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: HeaderInformationItemTableViewCell.identifier)
        tableDetailItem.register(UINib(nibName: OnlyTextInformationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: OnlyTextInformationTableViewCell.identifier)
        tableDetailItem.register(UINib(nibName: TwoTextInformationTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: TwoTextInformationTableViewCell.identifier)
        tableDetailItem.delegate = tableItemDetail
        tableDetailItem.dataSource = tableItemDetail
        tableDetailItem.reloadData()
    }
}
