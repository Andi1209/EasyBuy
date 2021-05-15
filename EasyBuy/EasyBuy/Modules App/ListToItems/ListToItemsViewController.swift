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
    private var indexSelect: Int = 0
    private var offset: Int = 0
    
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
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        view.addGestureRecognizer(tap)
        shearchItemBar.keyboardType = .alphabet
        shearchItemBar.delegate = self
        dontCategoriesLabel.isHidden = true
        loadInitialInformation()
    }
    
    // MARK: Use case
    func loadInitialInformation() {
        let request = ListToItems.LoadInitalData.Request()
        interactor?.loadInitialInformation(request: request)
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
//        listItemsTable.delegate = self
//        listItemsTable.dataSource = self
    }
}

// MARK: SearchBar
extension ListToItemsViewController:UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        dismissKeyboard()
    }
    
    
}


    // MARK: UICollection
extension ListToItemsViewController : UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = caregories.enumerated().filter({ $0.element.seleted }).map({ $0.offset })
        if index.isEmpty {
            caregories[indexPath.item].seleted.toggle()
        }else if index.first != indexPath.item {
            caregories[index.first ?? 0].seleted.toggle()
            caregories[indexPath.item].seleted.toggle()
        }
        categoriesColllection.reloadData()
        let request = ListToItems.GetCategorie.Request(category: caregories[indexPath.item].id ?? "", offset: "\(offset)")
        interactor?.getCategoreInformation(request: request)
    }
    
}

extension ListToItemsViewController:UICollectionViewDataSource {
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


