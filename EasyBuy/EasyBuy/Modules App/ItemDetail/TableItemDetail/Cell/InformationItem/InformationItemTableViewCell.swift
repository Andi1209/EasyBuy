//
//  InformationItemTableViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit
import SDWebImage

class InformationItemTableViewCell: UITableViewCell {
    
    static let identifier:String = "InformationItemTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var imageStatusNewPeoduct: UIImageView!
    @IBOutlet weak var imageFreeDelivery: UIImageView!
    @IBOutlet weak var imageItem: UIImageView!
    @IBOutlet weak var nameItem: BigTitleSemiboldLabel!
    @IBOutlet weak var priceItem: BigSubtitleBoldLabel!
    @IBOutlet weak var installmentItem: BigBodyRegularGreenLabel!
    @IBOutlet weak var cuantity: BigBodyRegularBlueLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setCell(item:ItemModel){
        imageStatusNewPeoduct.isHidden = item.condition
        imageFreeDelivery.isHidden = item.freeShipping
        imageItem.sd_setImage(with: URL(string: item.image.replacingOccurrences(of: "http:", with: "https:")) , placeholderImage: UIImage(named: "bagTobuy"))
        nameItem.text = item.name
        priceItem.text = item.price
        installmentItem.text = item.installments
        cuantity.text = "Cantidad disponible: \(item.soldQuantity)"
    }
    
}
