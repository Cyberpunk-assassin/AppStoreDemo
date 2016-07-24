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
        if self.selectedIndexNumber == 1 {
            return reviewsRowCount
        }
        return self.numberOfRowsInSection
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if self.selectedIndexNumber == 0{
            switch(indexPath.row){
            case 0:
                let newCell = tableView.dequeueReusableCellWithIdentifier("ScreenShotTblCell", forIndexPath: indexPath) as! ScreenShotTableViewCell
                if let arr = self.currentDetails.screenshotUrls {
                    newCell.configureImage(arr)
                }
                cell = newCell
                
            case 1:
                let newCell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! DescriptionTableViewCell
                if let desc = self.currentDetails.descriptions {
                    
                    newCell.configure("Description",desc: desc)}
                newCell.refreshCell = {
                    () -> Void in
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
                return newCell
            case 2:
                let newCell = tableView.dequeueReusableCellWithIdentifier("WhatsNewCell", forIndexPath: indexPath) as! WhatsNewTableViewCell
                if let notes = self.currentDetails.releaseNotes, let date =  self.currentDetails.currentVersionReleaseDate{
                    
                    newCell.configure("What's New", releaseDate: date, desc: notes)}
                return newCell
            case 3:
                let newCell = tableView.dequeueReusableCellWithIdentifier("InfoCell", forIndexPath: indexPath) as! InfoTableViewCell
                if self.currentDetails.artistName != nil{
                    newCell.configure(self.currentDetails)
                }
                return newCell
                
            case 4...3+extraArr.count:
                let newCell = tableView.dequeueReusableCellWithIdentifier("ExtraCell", forIndexPath: indexPath)
                newCell.textLabel?.text = extraArr[indexPath.row-4]
                
                return newCell
            default: break
            }
            
        }
        else if self.selectedIndexNumber == 1{
            switch(indexPath.row){
            case 0:
                let newCell = tableView.dequeueReusableCellWithIdentifier("RatingsReviewTableViewCell") as! RatingsReviewTableViewCell
                
                newCell.ratingView.setRating(0.0)
                newCell.fiveRatingView.setRating(0.0)
                newCell.fourRatingView.setRating(1.0)
                newCell.threeRatingView.setRating(2.0)
                newCell.twoRatingView.setRating(3.0)
                newCell.oneRatingView.setRating(4.0)
                
                if self.reviewArray.count != 0 {
                    newCell.configure(reviewArray)
                }
                
                cell = newCell
            case 1:
                let newCell = tableView.dequeueReusableCellWithIdentifier("CustomerReviewTableViewCell", forIndexPath: indexPath) as! CustomerReviewTableViewCell
                cell = newCell
            case 2...2+reviewArray.count:
                let newCell = tableView.dequeueReusableCellWithIdentifier("CommentsReviewTableViewCell", forIndexPath: indexPath) as! CommentsReviewTableViewCell
                if self.reviewArray.count != 0 {
                    newCell.configure(reviewArray[indexPath.row-2], number: indexPath.row-1)
                }
                newCell.refreshCell = {
                    () -> Void in
                    tableView.beginUpdates()
                    tableView.endUpdates()
                }
                
                cell = newCell
            default: break
            }
            
        }
        else if self.selectedIndexNumber == 2{
            switch (indexPath.row) {
            case 0:
                let newCell = tableView.dequeueReusableCellWithIdentifier("RelatedTVCell", forIndexPath: indexPath) as! RelatedTableViewCell
                newCell.seeAllButton.hidden = true
                if self.relatedDetails.count != 0 {
                    newCell.configure("More by \(self.currentDetails.artistName)", dataArray: self.relatedDetails)
                    newCell.seeAllButton.hidden = false
                }
                newCell.delegate = self
                return newCell
            case 1:
                
                let newCell = tableView.dequeueReusableCellWithIdentifier("RelatedTVCell", forIndexPath: indexPath) as! RelatedTableViewCell
                if self.relatedDetails.count != 0 {
                    newCell.configure("Customers Also Bought", dataArray: self.relatedDetails)
                }
                newCell.seeAllButton.hidden = true
                newCell.delegate = self
                return newCell
            default: break
                
            }
        }
        return cell
    }

}