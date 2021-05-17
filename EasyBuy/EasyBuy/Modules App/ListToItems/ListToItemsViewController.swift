//
//  ListToItemsViewController.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.

import UIKit

protocol ListToItemsDisplayLogic: AnyObject {
    func displayInitialInformation(viewModel: ListToItems.LoadInitalData.ViewModel)
    func displayInitialInformationError(viewModel: ListToItems.ErrorCategorias.ViewModel)
    func displayCategoreInformation(viewModel: ListToItems.GetCategorie.ViewModel)
    func displayNextPageItemInformation(viewModel: ListToItems.GetCategorie.ViewModel)
    func displaygetItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel)
    func displayNextItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel)
    func displayErroItemInformation(viewModel:ServiceError.ErrorGeneral.ViewModel)
}

class ListToItemsViewController: BaseViewController, ListToItemsDisplayLogic {
    
    var interactor: ListToItemsBusinessLogic?
    var router: (NSObjectProtocol & ListToItemsRoutingLogic & ListToItemsDataPassing)?
    // MARK: Outlets
    @IBOutlet weak var shearchItemBar: UISearchBar!
    @IBOutlet weak var categoriesColllection: UICollectionView!
    @IBOutlet weak var listItemsTable: UITableView!
    @IBOutlet weak var dontCategoriesLabel: TitleMediumLabel!
    
    
    // MARK: var-let
    private var caregories : [Categorie] = []
    private var items:[ItemModel] = []
    private var categotiCurrent: String = ""
    private var textCurrent: String = ""
    private var wattingService:Bool = false
    private var areThereMoreItems:Bool = false
    private var isLandscape:Bool = UIDevice.current.orientation.isLandscape

    
    
    // MARK: Actions button
    
    // MARK: Object lifecycle
    init() {
        let className = NSStringFromClass(ListToItemsViewController.self).split(separator: ".")
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
    
    override func viewDidLayoutSubviews() {
            if UIScreen.main.bounds.size.width < UIScreen.main.bounds.size.height {
                isLandscape = false
            } else {
                isLandscape = true
            }
        }
    
    // MARK: Setup
    private func setup() {
        let viewController = self
        let interactor = ListToItemsInteractor()
        let presenter = ListToItemsPresenter()
        let router = ListToItemsRouter()
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
        NotificationCenter.default.addObserver(self, selector: #selector(viewWillTransitionToSize), name: UIDevice.orientationDidChangeNotification, object: nil)
        shearchItemBar.keyboardType = .alphabet
        shearchItemBar.delegate = self
        dontCategoriesLabel.isHidden = true
        listItemsTable.delegate = self
        listItemsTable.dataSource = self
        listItemsTable.register(UINib(nibName: ItemTableViewCell.identifier, bundle: nil), forCellReuseIdentifier: ItemTableViewCell.identifier)
        loadInitialInformation()
    }
    
    deinit {
       NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
    }
    
    @objc func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if size.height == 0.0 {
            if UIDevice.current.orientation.isLandscape  {
                isLandscape = true
            } else {
                isLandscape = false
            }
            categoriesColllection.reloadData()
            listItemsTable.reloadData()
        }
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = ListToItems.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
    }
    
    func getNextPageItem(){
        if areThereMoreItems {
            if !wattingService {
                wattingService = true
                if categotiCurrent == "" {
                    let request = ListToItems.GetItemForName.Request(name: self.textCurrent)
                    interactor?.getNextItemForNameInformation(request: request)
                }else{
                    let request = ListToItems.GetCategorie.Request(category: categotiCurrent)
                    interactor?.getNextPageItemInformation(request: request)
                }
            }
        }
    }
    
    // MARK: Display
    func displayInitialInformation(viewModel: ListToItems.LoadInitalData.ViewModel) {
        self.caregories = viewModel.caregories
        categoriesColllection.delegate = self
        categoriesColllection.dataSource = self
        categoriesColllection.register(UINib(nibName: CategoriesCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
        categoriesColllection.backgroundColor = UIColor.grayApp
    }
    
    func displayInitialInformationError(viewModel: ListToItems.ErrorCategorias.ViewModel) {
        categoriesColllection.isHidden = true
        dontCategoriesLabel.text = viewModel.messageErrorCategories
        dontCategoriesLabel.isHidden = false
    }
    
    func displayCategoreInformation(viewModel: ListToItems.GetCategorie.ViewModel) {
        self.items = viewModel.items
        self.areThereMoreItems = viewModel.areThereMoreItems
        listItemsTable.reloadData()
    }
    
    func displayNextPageItemInformation(viewModel: ListToItems.GetCategorie.ViewModel){
        for item in viewModel.items {
            self.items.append(item)
        }
        wattingService = false
        self.areThereMoreItems = viewModel.areThereMoreItems
        listItemsTable.reloadData()
    }
    
    func displaygetItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel) {
        if items.count > 0 {
            listItemsTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        let index = caregories.enumerated().filter({ $0.element.id == categotiCurrent }).map({ $0.offset })
        if let id = index.first {
            caregories[id].seleted.toggle()
        }
        categotiCurrent = ""
        self.items = viewModel.items
        self.areThereMoreItems = viewModel.areThereMoreItems
        categoriesColllection.reloadData()
        listItemsTable.reloadData()
    }
    
    
    func displayNextItemForNameInformation(viewModel: ListToItems.GetItemForName.ViewModel) {
        for item in viewModel.items {
            self.items.append(item)
        }
        wattingService = false
        self.areThereMoreItems = viewModel.areThereMoreItems
        listItemsTable.reloadData()
    }
    
    
    func displayErroItemInformation(viewModel: ServiceError.ErrorGeneral.ViewModel) {
        wattingService = false
        let alert = AlertViewController(text: viewModel.errorMesage)
        alert.modalPresentationStyle = .overFullScreen
        self.present(alert, animated: false, completion: nil)
    }
    
    
    
}

 //MARK: SearchBar
extension ListToItemsViewController:UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let size = searchBar.text?.count else {
            return
        }
        if size > 3 {
            guard let text = searchBar.text else {
                return
            }
            self.textCurrent = text
            let request = ListToItems.GetItemForName.Request(name: text)
            interactor?.getItemForNameInformation(request: request)
            dismissKeyboard()
        }

    }
}


// MARK: UICollection
extension ListToItemsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = caregories.enumerated().filter({ $0.element.seleted }).map({ $0.offset })
        guard let id = caregories[indexPath.item].id else {return}
        if index.isEmpty {
            caregories[indexPath.item].seleted.toggle()
        }else if index.first != indexPath.item {
            caregories[index.first ?? 0].seleted.toggle()
            caregories[indexPath.item].seleted.toggle()
        }
        self.categotiCurrent = id
        categoriesColllection.reloadData()
        if items.count > 0 {
            listItemsTable.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        }
        dismissKeyboard()
        let request = ListToItems.GetCategorie.Request(category: id)
        interactor?.getCategoreInformation(request: request)
    }
    
}

extension ListToItemsViewController : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return caregories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellCollection = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
        let categorie = caregories[indexPath.item]
        if categorie.seleted{
            cellCollection.setCategoriesSelected(name: categorie.name ?? "")
        }else{
            cellCollection.setCategoriesNoSelected(name: categorie.name ?? "")
        }
        return cellCollection
    }
}

extension ListToItemsViewController :  UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let height = (collectionView.bounds.height - (collectionView.bounds.height * 0.11))
        let size = CGSize(width:width/2.2, height: height)
        return size
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
}

// MARK: UITableView
extension ListToItemsViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if self.items.count > 0 {
            if indexPath.row == items.count - 1{
                self.getNextPageItem()
            }
        }
    }
    
}

extension ListToItemsViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        let item = self.items[indexPath.row]
        cell.setCell(item:item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLandscape {
            return tableView.frame.height * 0.5
        }else{
            return tableView.frame.height * 0.27
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.item = self.items[indexPath.row]
        router?.routeToDetalleToItem()
    }
    
}

