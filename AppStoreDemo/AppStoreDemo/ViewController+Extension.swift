//
//  ViewController+Extension.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import Foundation
import UIKit

extension ViewController {

    func getDetailsData(){
        
        let url:NSURL! = NSURL(string: "https://itunes.apple.com/lookup?id=\(trackId)")
        task = session.downloadTaskWithURL(url, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if location != nil{
                let data:NSData! = NSData(contentsOfURL:location!)
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves)
                    let results = dic.valueForKey("results") as! [AnyObject]
                    if let dictionary = results[0] as? [String:AnyObject]{
                        
                        self.currentDetails.screenshotUrls = (dictionary["screenshotUrls"] as? [String])
                        self.currentDetails.artworkUrl60 = (dictionary["artworkUrl100"] as? String)!
                        self.currentDetails.kind = (dictionary["kind"] as? String)!
                        self.currentDetails.trackCensoredName = (dictionary["trackCensoredName"] as? String)!
                        self.currentDetails.language = (dictionary["languageCodesISO2A"] as? [String])!
                        self.currentDetails.trackContentRating = (dictionary["trackContentRating"] as? String)!
                        self.currentDetails.averageUserRating = (dictionary["averageUserRating"] as? Int)!
                        self.currentDetails.userRatingCountForCurrentVersion = (dictionary["userRatingCountForCurrentVersion"] as? Int)!
                        self.currentDetails.version = (dictionary["version"] as? String)!
                        self.currentDetails.descriptions = (dictionary["description"] as? String)!
                        self.currentDetails.artistId = (dictionary["artistId"] as? Int)!
                        self.currentDetails.artistName = (dictionary["artistName"] as? String)!
                        self.currentDetails.formattedPrice = (dictionary["formattedPrice"] as? String)!
                        self.currentDetails.compatibility = (dictionary["minimumOsVersion"] as? String)!
                        self.currentDetails.trackName = (dictionary["trackName"] as? String)!
                        self.currentDetails.trackId = (dictionary["trackId"] as? Int)!
                        self.currentDetails.currentVersionReleaseDate = (dictionary["currentVersionReleaseDate"] as? String)!.convertDateFormater()
                        self.currentDetails.primaryGenreName = (dictionary["primaryGenreName"] as? String)!
                        self.currentDetails.releaseNotes = (dictionary["releaseNotes"] as? String)!
                        self.currentDetails.sellerName = (dictionary["sellerName"] as? String)!
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
    }
    
    
    func getRelatedDetailsData(){
        self.relatedDetails = []
        let url:NSURL! = NSURL(string: "https://itunes.apple.com/lookup?id=\(artistId)&entity=software")
        task = session.downloadTaskWithURL(url, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if location != nil{
                let data:NSData! = NSData(contentsOfURL:location!)
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves)
                    let data = dic.valueForKey("results") as! [AnyObject]
                    for i in 1..<10 {
                        let details = Details()
                        if let dictionary = data[i] as? [String:AnyObject]{
                            
                            details.screenshotUrls = (dictionary["screenshotUrls"] as? [String])
                            details.artworkUrl60 = (dictionary["artworkUrl100"] as? String)!
                            details.kind = (dictionary["kind"] as? String)!
                            details.trackCensoredName = (dictionary["trackCensoredName"] as? String)!
                            details.language = (dictionary["languageCodesISO2A"] as? [String])!
                            details.trackContentRating = (dictionary["trackContentRating"] as? String)!
                            details.averageUserRating = (dictionary["averageUserRating"] as? Int)!
                            details.userRatingCountForCurrentVersion = (dictionary["userRatingCountForCurrentVersion"] as? Int)!
                            details.version = (dictionary["version"] as? String)!
                            details.descriptions = (dictionary["description"] as? String)!
                            details.artistId = (dictionary["artistId"] as? Int)!
                            details.artistName = (dictionary["artistName"] as? String)!
                            details.formattedPrice = (dictionary["formattedPrice"] as? String)!
                            details.compatibility = (dictionary["minimumOsVersion"] as? String)!
                            details.trackName = (dictionary["trackName"] as? String)!
                            details.trackId = (dictionary["trackId"] as? Int)!
                            details.currentVersionReleaseDate = (dictionary["currentVersionReleaseDate"] as? String)!.convertDateFormater()
                            details.primaryGenreName = (dictionary["primaryGenreName"] as? String)!
                            details.releaseNotes = (dictionary["releaseNotes"] as? String)!
                            details.sellerName = (dictionary["sellerName"] as? String)!
                            self.relatedDetails.append(details)
                            
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }catch{
                    print("something went wrong, try again")
                }
            }
        })
        task.resume()
    }
    
    func getCommentsArray(){
        self.reviewArray = []
        let url:NSURL! = NSURL(string: "https://itunes.apple.com/rss/customerreviews/id=\(trackId)/sortBy=mostRecent/json")
        task = session.downloadTaskWithURL(url, completionHandler: { (location: NSURL?, response: NSURLResponse?, error: NSError?) -> Void in
            
            if location != nil{
                let data:NSData! = NSData(contentsOfURL:location!)
                do{
                    let dic = try NSJSONSerialization.JSONObjectWithData(data, options: .MutableLeaves)
                    let data = dic.valueForKey("feed")
                    let entry = data?.valueForKey("entry") as! [AnyObject]
                    for i in 1..<entry.count {
                        let review = ReviewsModel()
                        if let dictionary = entry[i] as? [String:AnyObject] {
                            review.rating = (dictionary["im:rating"]!["label"] as? String)
                            review.commentHeader = (dictionary["title"]!["label"] as? String)
                            review.comment = (dictionary["content"]!["label"] as? String)
                            let username = (dictionary["author"]?["name"])! as AnyObject
                            review.userName = (username["label"] as? String)
                            self.reviewArray.append(review)
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.tableView.reloadData()
                    })
                }catch{
                    print("Something went wrong, try again")
                }
            }
        })
        task.resume()
    }
}