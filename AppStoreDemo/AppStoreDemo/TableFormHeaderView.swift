//
//  TableFormHeaderView.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

protocol TableFormHeaderViewDelegate {
    func filteringSegmentView(sender: UISegmentedControl?)
}
class TableFormHeaderView: UITableViewHeaderFooterView {

    @IBOutlet weak var ratingsCount: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet var contentsView: UIView?
    @IBOutlet var imageViewApp: UIImageView?
    @IBOutlet var lblAppName: UILabel?
    @IBOutlet var companyName: UILabel?
    @IBOutlet var lblRating: UILabel?
    @IBOutlet var btnDownloadApp: UIButton?
    @IBOutlet var segmentControl: UISegmentedControl?
    
    var delegate : TableFormHeaderViewDelegate!
    
    @IBAction func segmentPressed(sender: UISegmentedControl) {
        if((self.delegate) != nil){
            delegate?.filteringSegmentView(sender)
            
        }
    }
    


    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
