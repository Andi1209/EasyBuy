//
//  TableItemDetail.swift
//  EasyBuy
//
//  Created by Andres Felipe Nunez on 17/05/21.
//

import UIKit

class TableItemDetail: UITableViewController{
    var item:ItemModel!
    var isLandscape:Bool!
    
    
    deinit {
        print("TableItemDetail + deinit")
    }
    

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTableViewCell.identifier, for: indexPath) as! ItemTableViewCell
        cell.setCell(item:item)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if isLandscape {
            return tableView.frame.height * 0.5
        }else{
            return tableView.frame.height * 0.27
        }
           
    }
}
