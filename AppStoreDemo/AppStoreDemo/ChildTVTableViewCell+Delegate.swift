//
//  ChildTVTableViewCell+Delegate.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import Foundation
import UIKit

extension ChildTVTableViewCell : UITableViewDelegate {
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var rowHeight: CGFloat = 100.0
        if self.selectedIndexNumber == 0 {
            switch(indexPath.row){
            case 0:
                rowHeight = 200
                
            default:
                rowHeight = UITableViewAutomaticDimension
            }
            
        } else if self.selectedIndexNumber == 1 {
            rowHeight = UITableViewAutomaticDimension
            
        }
        else if self.selectedIndexNumber == 2 {
            
            rowHeight = 190
            
        }
        return rowHeight
    }
        
}
