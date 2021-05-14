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
    @IBOutlet weak var text: UILabel!
    
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
        loadInitialInformation()
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = Launcher.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: Launcher.LoadInitalData.ViewModel) {
        text.text = NSLocalizedString("text", comment: "")
        //nameTextField.text = viewModel.name
    }
}
