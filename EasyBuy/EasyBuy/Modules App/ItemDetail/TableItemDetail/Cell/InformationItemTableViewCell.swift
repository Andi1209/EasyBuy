//
//  InformationItemTableViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class InformationItemTableViewCell: UITableViewCell {
    
    static let identifier:String = "InformationItemTableViewCell"
    
    //MARK: IBOutlets

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
