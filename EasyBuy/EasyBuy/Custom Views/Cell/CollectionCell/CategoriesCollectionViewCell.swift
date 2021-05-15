//
//  CategoriesCollectionViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 14/05/21.
//

import UIKit

class CategoriesCollectionViewCell: UICollectionViewCell {
    
    
    static let identifier:String = "CategoriesCollectionViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var viewCategorie: UIView!
    @IBOutlet weak var textCategorie: BodyMediumLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCategoriesSelected(name:String){
        self.viewCategorie.roundClipsToBounds()
        self.viewCategorie.dropShadow()
        self.textCategorie.textColor = UIColor.black
        self.textCategorie.text = name
        self.viewCategorie.backgroundColor = UIColor.yellowApp
    }
    
    func setCategoriesNoSelected(name:String){
        self.viewCategorie.roundClipsToBounds()
        self.viewCategorie.dropShadow()
        self.textCategorie.textColor = UIColor.blackAlphaApp
        self.textCategorie.text = name
        self.viewCategorie.backgroundColor = UIColor.yellowAlphaApp
    }

}
