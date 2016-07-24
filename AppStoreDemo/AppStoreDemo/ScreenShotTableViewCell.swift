//
//  ScreenShotTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class ScreenShotTableViewCell: UITableViewCell, UICollectionViewDataSource {

    var screenShotImgArr = [String]()
    var refreshCtrl: UIRefreshControl!
    var tableData:[AnyObject]!
    var task: NSURLSessionDownloadTask!
    var session: NSURLSession!
    var cache:NSCache!
    
    @IBOutlet weak var screenShotCollectionView: UICollectionView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
        
        
        self.cache = NSCache()
        
        self.screenShotCollectionView.registerNib(UINib(nibName: "ScreenShotCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScreenShotCVCell")
    }

    func configureImage(urlArray : [String]){
        self.screenShotImgArr = urlArray
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.screenShotCollectionView.reloadData()
        })
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if screenShotImgArr.count != 0 {
            return screenShotImgArr.count

        }
        return 5
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ScreenShotCVCell", forIndexPath: indexPath) as! ScreenShotCollectionViewCell
        cell.screenShotImgView?.image = UIImage(named: "placeholder")
        
        if (self.cache.objectForKey(indexPath.row) != nil){
            cell.screenShotImgView?.image = self.cache.objectForKey(indexPath.row) as? UIImage
        }else{
            if screenShotImgArr.count != 0 {
                let artworkUrl = self.screenShotImgArr[indexPath.row]
                let url:NSURL! = NSURL(string: artworkUrl)
                task = session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
                    if let data = NSData(contentsOfURL: url){
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if let updateCell = collectionView.cellForItemAtIndexPath(indexPath) as? ScreenShotCollectionViewCell{
                                let img:UIImage! = UIImage(data: data)
                                updateCell.screenShotImgView?.image = img
                                self.cache.setObject(img, forKey: indexPath.row)
                            }
                        })
                    }
                })
                task.resume()
            }
        }
        return cell
    }

}