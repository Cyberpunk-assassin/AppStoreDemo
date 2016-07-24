//
//  ViewController.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TableFormHeaderViewDelegate, RelatedTableViewCellDelegate {
    
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
        
        registerDetailTableCells()
        registerRelatedDetailTableCells()
        registerReviewsTableCells()
        
        filteringSegmentView(nil)
        // Do any additional setup after loading the view, typically from a nib.
        let nib = UINib(nibName: "TableFormHeaderView", bundle: nil)
        tableView.registerNib(nib, forHeaderFooterViewReuseIdentifier: "TableFormHeaderView")
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
        
    //registers each table cell xib with tableview
    func registerDetailTableCells() {
        self.tableView.registerNib(UINib(nibName: "ScreenShotTableViewCell", bundle: nil), forCellReuseIdentifier: "ScreenShotTblCell")
        self.tableView.registerNib(UINib(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionCell")
        self.tableView.registerNib(UINib(nibName: "WhatsNewTableViewCell", bundle: nil), forCellReuseIdentifier: "WhatsNewCell")
        self.tableView.registerNib(UINib(nibName: "InfoTableViewCell", bundle: nil), forCellReuseIdentifier: "InfoCell")
        self.tableView.registerNib(UINib(nibName: "ExtraCell", bundle: nil), forCellReuseIdentifier: "ExtraCell")
    }
    func registerRelatedDetailTableCells() {
        self.tableView.registerNib(UINib(nibName: "RelatedAppTableViewCell", bundle: nil), forCellReuseIdentifier: "RelatedTVCell")
    }
    
    func registerReviewsTableCells() {
        self.tableView.registerNib(UINib(nibName: "RatingsReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "RatingsReviewTableViewCell")
        self.tableView.registerNib(UINib(nibName: "CustomerReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomerReviewTableViewCell")
        self.tableView.registerNib(UINib(nibName: "CommentsReviewTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsReviewTableViewCell")
    }
    
    func filteringSegmentView(sender: UISegmentedControl?) {
        self.selectedIndexNumber = sender?.selectedSegmentIndex ?? 0
        
        switch self.selectedIndexNumber {
        case 0:
            self.getDetailsData()
            self.numberOfRowsInSection = 4+extraArr.count
            break
        case 1:
            self.numberOfRowsInSection = 2
            getCommentsArray()
            break
        case 2:
            self.getRelatedDetailsData()
            self.numberOfRowsInSection = 2
            break
        default: break
        }
        tableView.reloadData()
    }
    
    func pushViewController(vc: ViewController!) {
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

