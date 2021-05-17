//
//  HeaderInformationItemTableViewCell.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class HeaderInformationItemTableViewCell: UITableViewCell {
    
    
    static let identifier:String = "HeaderInformationItemTableViewCell"
    
    //MARK: IBOutlets
    @IBOutlet weak var title: SubtitleMediumLabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
        self.backgroundColor = UIColor.grayApp
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setCell(title:String){
        self.title.text = title
    }
    
}
