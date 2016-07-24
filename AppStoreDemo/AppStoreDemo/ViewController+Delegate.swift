//
//  ViewController+Delegate.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import Foundation
import UIKit

extension ViewController : UITextViewDelegate {
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
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = self.tableView.dequeueReusableHeaderFooterViewWithIdentifier("TableFormHeaderView")
        let header = view as! TableFormHeaderView
        //        if !UIAccessibilityIsReduceTransparencyEnabled() {
        //            header.contentsView!.backgroundColor = UIColor.clearColor()
        //
        //            let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.ExtraLight)
        //            let blurEffectView = UIVisualEffectView(effect: blurEffect)
        //            blurEffectView.frame = header.contentsView!.bounds
        //            blurEffectView.autoresizingMask = [.FlexibleWidth, .FlexibleHeight]
        //
        //            header.contentsView?.addSubview(blurEffectView)
        //        }
        header.imageViewApp?.image = UIImage(named: "placeholder")
        headerImageView.image = UIImage(named: "placeholder")
        header.ratingView.setRating(5.0)
        if let imageURL = self.currentDetails?.screenshotUrls  {
            
            let url:NSURL! = NSURL(string: imageURL[0])
            if let data = NSData(contentsOfURL: url){
                let img:UIImage! = UIImage(data: data)
                headerImageView.image = img
                
            }
        }
        header.ratingsCount.text = "(\(self.ratingsCount))"
        if (self.cache.objectForKey("appIcon") != nil){
            header.imageViewApp?.image = self.cache.objectForKey("appIcon") as? UIImage
        }else{
            if let artWork = self.currentDetails.artworkUrl60  {
                let artworkUrl = artWork
                let url:NSURL! = NSURL(string: artworkUrl)
                task = session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
                    if let data = NSData(contentsOfURL: url){
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            let img:UIImage! = UIImage(data: data)
                            header.imageViewApp?.image = img
                            header.lblAppName?.text = self.currentDetails.trackCensoredName
                            header.companyName?.text = self.currentDetails.sellerName + ">"
                            header.lblRating?.text = self.currentDetails.trackContentRating
                            header.btnDownloadApp?.setTitle(self.currentDetails.formattedPrice, forState: UIControlState.Normal)
                            self.cache.setObject(img, forKey: "appIcon")
                            
                        })
                    }
                })
                task.resume()
            }
        }
        header.delegate = self
        
        
        return header
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
        
    }

}