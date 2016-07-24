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





//{
//    "resultCount":1,
//    "results": [
//    {
//    "screenshotUrls":["http://a3.mzstatic.com/us/r30/Purple30/v4/eb/55/22/eb552268-00cf-d8f3-d79c-668697344f45/screen320x320.jpeg", "http://a5.mzstatic.com/us/r30/Purple20/v4/1c/1f/8c/1c1f8c27-be6c-9b59-0caf-385949f07b16/screen320x320.jpeg", "http://a1.mzstatic.com/us/r30/Purple20/v4/bc/f8/80/bcf8808b-d6bd-3157-2e95-665c6d3047ec/screen320x320.jpeg", "http://a4.mzstatic.com/us/r30/Purple20/v4/17/53/f1/1753f174-fe86-0dbb-2535-8d1bb5ead189/screen320x320.jpeg", "http://a3.mzstatic.com/us/r30/Purple30/v4/20/ca/c2/20cac2c9-bc5f-7128-1c4c-3d072af64567/screen320x320.jpeg"],
//    "ipadScreenshotUrls":["http://a2.mzstatic.com/us/r30/Purple18/v4/e6/97/60/e69760af-e41a-f66e-639f-3ba317854fda/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple60/v4/1a/f5/de/1af5deb5-a247-6f14-11cf-ded46fd1b29f/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple18/v4/d2/a6/d0/d2a6d07a-5074-e414-760b-22903c9fe441/screen480x480.jpeg", "http://a2.mzstatic.com/us/r30/Purple18/v4/08/fa/f6/08faf651-a446-4214-224b-d2b71c24199c/screen480x480.jpeg", "http://a5.mzstatic.com/us/r30/Purple20/v4/6a/f8/b2/6af8b23b-c379-8cfd-a2a0-291c054dd18a/screen480x480.jpeg"],
//    "appletvScreenshotUrls":[],
//    "artworkUrl60":"http://is3.mzstatic.com/image/thumb/Purple18/v4/4d/f1/6f/4df16f2b-133c-3a88-0713-64119d29f580/source/60x60bb.jpg",
//    "artworkUrl512":"http://is3.mzstatic.com/image/thumb/Purple18/v4/4d/f1/6f/4df16f2b-133c-3a88-0713-64119d29f580/source/512x512bb.jpg",
//    "artworkUrl100":"http://is3.mzstatic.com/image/thumb/Purple18/v4/4d/f1/6f/4df16f2b-133c-3a88-0713-64119d29f580/source/100x100bb.jpg",
//    "artistViewUrl":"https://itunes.apple.com/us/developer/square-enix-inc/id300186801?mt=8&uo=4",
//    "isGameCenterEnabled":false,
//    "kind":"software",
//    "features":["iosUniversal"],
//    "supportedDevices":["iPad2Wifi", "iPad23G", "iPhone4S", "iPadThirdGen", "iPadThirdGen4G", "iPhone5", "iPodTouchFifthGen", "iPadFourthGen", "iPadFourthGen4G", "iPadMini", "iPadMini4G", "iPhone5c", "iPhone5s", "iPhone6", "iPhone6Plus", "iPodTouchSixthGen"],
//    "advisories":["Infrequent/Mild Alcohol, Tobacco, or Drug Use or References", "Infrequent/Mild Horror/Fear Themes", "Frequent/Intense Realistic Violence", "Infrequent/Mild Mature/Suggestive Themes"],
//    "trackCensoredName":"Hitman: Sniper",
//    "languageCodesISO2A":["ZH", "EN", "FR", "DE", "IT", "JA", "KO", "PT", "RU", "ES"],
//    "fileSizeBytes":"601924758",
//    "contentAdvisoryRating":"17+",
//    "averageUserRatingForCurrentVersion":4.5,
//    "userRatingCountForCurrentVersion":60,
//    "trackViewUrl":"https://itunes.apple.com/us/app/hitman-sniper/id904278510?mt=8&uo=4",
//    "trackContentRating":"17+",
//    "currency":"USD",
//    "wrapperType":"software",
//    "version":"2.0.2",
//    "description":"*** 80% OFF for a limited time! ***\n\n5/5 - \"Now that it’s here, I can’t stop playing it, which is remarkable for a title that is much more concerned with showcasing how much you can do within certain constraints instead of reveling in any kind of excess.\" - Gamezebo\n4/5 - \"Aiming and shooting within a single environment avoids being bland because Hitman: Sniper has a lot of variety packed into its details.\" -148 Apps\n\nBECOME THE ULTIMATE SILENT ASSASSIN\nStep into the shoes of Agent 47 in Hitman: Sniper and discover the most compelling sniper experience on mobile.\n \nTACTICAL MISSIONS IN MONTENEGRO\nHone your strategic skills and orchestrate the perfect assassination.\n \nACTION ZOMBIE CHALLENGE IN DEATH VALLEY\nPrepare for non-stop action in a true test of your accuracy and speed of execution.\n \nMORE THAN 150 MISSIONS AND 11 DIFFERENT CONTRACTS\nImprove your strategy for the perfect assassination as you uncover secrets and subterfuges.\n\n17 UNIQUE WEAPONS\nEliminate targets, collect weapon parts and complete blueprints to unlock the most powerful rifles.\n\nCOMPETE AGAINST YOUR FRIENDS TO DOMINATE THE LEADERBOARD\nBoost your score and climb up the ranks to become the world's finest silent assassin.\n\n\nHitman: Sniper is memory intensive. Devices such as iPad 2, iPad Mini, iPhone 4S and iPod Touch 5th Generation will suffer from occasional dips in performance and will not support Everyplay.",
//    "artistId":300186801,
//    "artistName":"SQUARE ENIX INC",
//    "genres":["Games", "Action", "Strategy"],
//    "price":0.99,
//    "trackName":"Hitman: Sniper",
//    "trackId":904278510,
//    "bundleId":"com.squareenixmontreal.hitmansniper",
//    "releaseDate":"2015-06-03T22:29:32Z",
//    "primaryGenreName":"Games",
//    "minimumOsVersion":"8.0",
//    "isVppDeviceBasedLicensingEnabled":true,
//    "currentVersionReleaseDate":"2016-07-12T13:47:42Z",
//    "releaseNotes":"What's New in Version 2.0.2\n\nVarious bug fixes and improvements",
//    "sellerName":"SQUARE ENIX Ltd",
//    "primaryGenreId":6014,
//    "genreIds":["6014", "7001", "7017"],
//    "formattedPrice":"$0.99",
//    "averageUserRating":4.5,
//    "userRatingCount":6121}]
//}




