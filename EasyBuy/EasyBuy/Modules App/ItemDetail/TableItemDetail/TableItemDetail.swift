//
//  TableItemDetail.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class TableItemDetail: UITableViewController{
    var item:ItemModel!
    var headerSellerInformation:String!
    var headerFeatureInformation:String!
    var isLandscape:Bool!
    
    
    deinit {
//        print("TableItemDetail + deinit")
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if item.attributes.count > 0 {
            return 4 + item.attributes.count
        }else{
            return 3
        }
       
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: InformationItemTableViewCell.identifier, for: indexPath) as! InformationItemTableViewCell
            cell.setCell(item:item)
            return cell
        case 1 :
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderInformationItemTableViewCell.identifier, for: indexPath) as! HeaderInformationItemTableViewCell
            cell.setCell(title: headerSellerInformation)
            return cell
        case 2 :
            let cell = tableView.dequeueReusableCell(withIdentifier: OnlyTextInformationTableViewCell.identifier, for: indexPath) as! OnlyTextInformationTableViewCell
            cell.setCell(value: item.address)
            return cell
        case 3 :
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderInformationItemTableViewCell.identifier, for: indexPath) as! HeaderInformationItemTableViewCell
            cell.setCell(title: headerFeatureInformation)
            return cell
        default:
            let attributes = item.attributes[indexPath.row - 4]
            let cell = tableView.dequeueReusableCell(withIdentifier: TwoTextInformationTableViewCell.identifier, for: indexPath) as! TwoTextInformationTableViewCell
            cell.setCell(subTitle: attributes.title, value: attributes.vale)
            return cell
        }
        
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLandscape {
            switch indexPath.row {
            case 0:
                return tableView.frame.height * 0.9
            case 1,3 :
                return tableView.frame.height * 0.15
            default:
                return UITableView.automaticDimension
            }
        }else{
            switch indexPath.row {
            case 0:
                return tableView.frame.height * 0.75
            case 1,3 :
                return tableView.frame.height * 0.08
            default:
                return UITableView.automaticDimension
            }
        }
           
    }
}
