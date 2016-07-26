//
//  ViewController.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TableFormHeaderViewDelegate, ChildTableViewCellDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headerImageView: UIImageView!
    
    var trackId : Int!
    var artistId : Int!

    var task: NSURLSessionDownloadTask!
    var session: NSURLSession!
    var cache:NSCache!

    var selectedIndexNumber:Int = 0
    var ratingsCount : Int = 0
    var numberOfRowsInSection : Int = 0
    var reviewsRowCount: Int = 0

    var currentDetails : Details!
    var relatedDetails = [Details]()
    var reviewArray = [ReviewsModel](){
        didSet{
            reviewsRowCount = 2+reviewArray.count
            ratingsCount = reviewArray.count
        }
    }
    
    var extraArr = ["In-App Purchases","Version History","Developer Website","License Agreement","Privacy Policy","Developer Apps"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if trackId == nil{
            trackId = NSUserDefaults.standardUserDefaults().integerForKey("currentTrackId")
        }
        if artistId == nil{
            artistId = NSUserDefaults.standardUserDefaults().integerForKey("currentArtistId")
        }
        
        session = NSURLSession.sharedSession()
        task = NSURLSessionDownloadTask()
        self.cache = NSCache()
        self.tableView.tableFooterView = UIView()
        
        currentDetails = Details()
        self.getDetailsData()
        self.getCommentsArray()
                
        filteringSegmentView(nil)
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "TableFormHeaderView", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableFormHeaderView")
        self.tableView.registerNib(UINib(nibName: "ChildTVTableViewCell", bundle: nil), forCellReuseIdentifier: "ChildTVTableViewCell")

        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.backgroundColor = UIColor.clearColor()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrolling(yOffset: CGFloat) {
        if (self.tableView.contentOffset.y<headerImageView.frame.height+6 && self.tableView.contentOffset.y >= 0 && yOffset < headerImageView.frame.height && yOffset >= 0){
            self.tableView.setContentOffset(CGPointMake(0, yOffset), animated: true)
        }
        else if yOffset > headerImageView.frame.height {
            self.tableView.setContentOffset(CGPointMake(0, headerImageView.frame.height), animated: true)
        }
    }
    
    //MARK: - TableFormHeaderViewDelegate
    func filteringSegmentView(sender: UISegmentedControl?) {
        self.selectedIndexNumber = sender?.selectedSegmentIndex ?? 0
        
        switch self.selectedIndexNumber {
        case 0:
            self.numberOfRowsInSection = 4+extraArr.count
            self.getDetailsData()
            break
        case 1:
            self.numberOfRowsInSection = 2
            getCommentsArray()
            break
        case 2:
            self.getRelatedDetailsData()
            
            break
        default: break
        }
        tableView.reloadData()
    }
    
    //MARK: - ChildTableViewCellDelegate
    func pushViewController(vc: ViewController!) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

    