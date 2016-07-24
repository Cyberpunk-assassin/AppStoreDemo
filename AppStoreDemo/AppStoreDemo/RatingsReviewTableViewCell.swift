//
//  RatingsReviewTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class RatingsReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var totalRatingsLabel: UILabel!
    @IBOutlet weak var ratingView: StarRatingView!
    @IBOutlet weak var fiveRatingView: StarRatingView!
    @IBOutlet weak var fourRatingView: StarRatingView!
    @IBOutlet weak var threeRatingView: StarRatingView!
    @IBOutlet weak var twoRatingView: StarRatingView!
    @IBOutlet weak var oneRatingView: StarRatingView!
    @IBOutlet weak var fiveRatingsProgressBar: UIProgressView!
    @IBOutlet weak var fourRatingsProgressBar: UIProgressView!
    @IBOutlet weak var threeRatingsProgressBar: UIProgressView!
    @IBOutlet weak var twoRatingsProgressBar: UIProgressView!
    @IBOutlet weak var oneRatingsProgressBar: UIProgressView!
    
    var numberOf5Ratings : Float = 0
    var numberOf4Ratings : Float = 0
    var numberOf3Ratings : Float = 0
    var numberOf2Ratings : Float = 0
    var numberOf1Ratings : Float = 0

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(reviewsArray : [ReviewsModel]) {
        self.calculateRatings(reviewsArray)
        let totalNumberOfRatings = Float(reviewsArray.count)
        self.fiveRatingsProgressBar.progress = numberOf5Ratings/totalNumberOfRatings
        self.fourRatingsProgressBar.progress = numberOf4Ratings/totalNumberOfRatings
        self.threeRatingsProgressBar.progress = numberOf3Ratings/totalNumberOfRatings
        self.twoRatingsProgressBar.progress = numberOf2Ratings/totalNumberOfRatings
        self.oneRatingsProgressBar.progress = numberOf1Ratings/totalNumberOfRatings
        self.totalRatingsLabel.text = "\(reviewsArray.count) Ratings"
    }
    
    func calculateRatings(reviewsArray : [ReviewsModel]){
        for review in reviewsArray {
            if Float(review.rating) == 5 {
                self.numberOf5Ratings += 1
            } else if Float(review.rating) == 4 {
                self.numberOf4Ratings += 1
            } else if Float(review.rating) == 3 {
                self.numberOf3Ratings += 1
            } else if Float(review.rating) == 2 {
                self.numberOf2Ratings += 1
            } else if Float(review.rating) == 1 {
                self.numberOf1Ratings += 1
            }
        }
    }
}
