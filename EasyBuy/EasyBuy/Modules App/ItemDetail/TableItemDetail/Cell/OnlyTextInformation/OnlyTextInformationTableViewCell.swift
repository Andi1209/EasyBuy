//
//  OnlyTextInformationTableViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class OnlyTextInformationTableViewCell: UITableViewCell {
    
    static let identifier:String = "OnlyTextInformationTableViewCell"
    
    //MARK: IBOutlets
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
    
    func setCell(value:String){
        self.value.text = value
    }
    
}
