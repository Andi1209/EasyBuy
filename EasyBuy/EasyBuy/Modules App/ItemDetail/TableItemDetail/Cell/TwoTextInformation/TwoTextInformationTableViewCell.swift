//
//  TwoTextInformationTableViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class TwoTextInformationTableViewCell: UITableViewCell {
    
    
    static let identifier:String = "TwoTextInformationTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var subTitle: BodyBoldLabel!
    @IBOutlet weak var value: BigBodyRegularGrayLightLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.backgroundColor = UIColor.white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(subTitle:String,value:String){
        self.subTitle.text = subTitle
        self.value.text = value
    }
    
}
