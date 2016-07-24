//
//  RelatedTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

protocol RelatedTableViewCellDelegate {
    func pushViewController(vc : ViewController!)
}
class RelatedTableViewCell: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var relatedCollectionView: UICollectionView!
    @IBOutlet weak var seeAllButton: UIButton!

    var task: NSURLSessionDownloadTask!
    var session: NSURLSession!
    var cache:NSCache!
    var relatedDetailsArr : [Details]!
    var delegate : RelatedTableViewCellDelegate!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
        relatedDetailsArr = [Details]()
        
        self.cache = NSCache()
        self.relatedCollectionView.registerNib(UINib(nibName: "RelatedAppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "RelatedCVCell")


    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(dev:String, dataArray : [Details]){
        self.titleLabel.text = dev
        self.relatedDetailsArr = dataArray
        self.relatedCollectionView.reloadData()
    }

    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return relatedDetailsArr.count

    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("RelatedCVCell", forIndexPath: indexPath) as! RelatedCollectionViewCell
        cell.imageView?.image = UIImage(named: "placeholder")
        
        if (self.cache.objectForKey(indexPath.row) != nil){
            cell.imageView?.image = self.cache.objectForKey(indexPath.row) as? UIImage
        }else{
            if relatedDetailsArr.count != 0 {
                let artworkUrl = self.relatedDetailsArr[indexPath.row].artworkUrl60
                let url:NSURL! = NSURL(string: artworkUrl)
                cell.titleLabel.text = self.relatedDetailsArr[indexPath.row].trackCensoredName
                cell.genreLabel.text = self.relatedDetailsArr[indexPath.row].primaryGenreName
                task = session.downloadTaskWithURL(url, completionHandler: { (location, response, error) -> Void in
                    if let data = NSData(contentsOfURL: url){
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if let updateCell = collectionView.cellForItemAtIndexPath(indexPath) as? RelatedCollectionViewCell{
                                let img:UIImage! = UIImage(data: data)
                                updateCell.imageView?.image = img

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
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let vc = ViewManager.sharedViewManager.getViewController()
        vc.trackId = self.relatedDetailsArr[indexPath.row].trackId
        vc.artistId = self.relatedDetailsArr[indexPath.row].artistId
        
        if((self.delegate) != nil){
            delegate?.pushViewController(vc)
        }
    }
}
