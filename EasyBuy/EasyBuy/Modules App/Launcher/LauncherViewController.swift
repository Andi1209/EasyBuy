//
//  LauncherViewController.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 13/05/21

import UIKit

protocol LauncherDisplayLogic: AnyObject {
    func displayInitialInformation(viewModel: Launcher.LoadInitalData.ViewModel)
}

class LauncherViewController: BaseViewController, LauncherDisplayLogic {
    var interactor: LauncherBusinessLogic?
    var router: (NSObjectProtocol & LauncherRoutingLogic & LauncherDataPassing)?
    // MARK: Outlets
    @IBOutlet weak var imageLauncher: UIImageView!
    
    // MARK: var-let
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    init() {
        let className = NSStringFromClass(LauncherViewController.self).split(separator: ".")
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
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = LauncherInteractor()
        let presenter = LauncherPresenter()
        let router = LauncherRouter()
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
        setEnableNavigationbar(type: .none)
        loadInitialInformation()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.view.setupGradient()
        imageLauncher.isHidden = false
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = Launcher.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: Launcher.LoadInitalData.ViewModel) {
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.router?.routeToListToItems()
        }
            
    }
}
