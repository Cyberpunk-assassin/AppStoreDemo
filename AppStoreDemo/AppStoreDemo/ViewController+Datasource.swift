//
//  ViewController+Datasource.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ChildTVTableViewCell", forIndexPath: indexPath) as! ChildTVTableViewCell
        cell.configureData(self.trackId, artistId: self.artistId, selectedIndexNumber: self.selectedIndexNumber, ratingsCount: self.ratingsCount, numberOfRowsInSection: self.numberOfRowsInSection, reviewsRowCount: self.reviewsRowCount, currentDetails: self.currentDetails, relatedDetails: self.relatedDetails, reviewArray: self.reviewArray)
        cell.delegate = self
        cell.refreshTableOffSet = {
                (offset) -> Void in
                self.scrolling(offset)
        }

        return cell
    }

}