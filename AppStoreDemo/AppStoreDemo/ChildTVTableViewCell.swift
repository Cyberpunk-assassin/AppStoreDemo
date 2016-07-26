//
//  ChildTVTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit
protocol ChildTableViewCellDelegate {
    func pushViewController(vc : ViewController!)
}

class ChildTVTableViewCell: UITableViewCell, RelatedTableViewCellDelegate {
    var trackId : Int!
    var artistId : Int!
    
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
    var refreshTableOffSet:((yOffset:CGFloat) -> Void)? = nil
    
    var extraArr = ["In-App Purchases","Version History","Developer Website","License Agreement","Privacy Policy","Developer Apps"]

    var delegate : ChildTableViewCellDelegate!
    @IBOutlet weak var tableView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.tableView.tableFooterView = UIView()
                
        registerDetailTableCells()
        registerRelatedDetailTableCells()
        registerReviewsTableCells()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
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

    func pushViewController(vc: ViewController!) {
        if((self.delegate) != nil){
            delegate?.pushViewController(vc)
        }
    }
    
    func configureData(trackId : Int!, artistId : Int!, selectedIndexNumber:Int, ratingsCount : Int,numberOfRowsInSection : Int,reviewsRowCount: Int, currentDetails : Details!, relatedDetails : [Details], reviewArray : [ReviewsModel]){
        self.trackId = trackId
        self.artistId = artistId
        
        self.selectedIndexNumber = selectedIndexNumber
        self.ratingsCount = ratingsCount
        self.numberOfRowsInSection  = numberOfRowsInSection
        self.reviewsRowCount = reviewsRowCount
        
        self.currentDetails = currentDetails
        self.relatedDetails = relatedDetails
        self.reviewArray = reviewArray
        self.tableView.reloadData()
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        refreshTableOffSet!(yOffset: scrollView.contentOffset.y)
    }
    
    
}
