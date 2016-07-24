//
//  StarRatingView.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

@IBDesignable
public class StarRatingView: UIView {
    
    @IBInspectable var maxRating: Int = 5
    @IBInspectable var fullStarImage: UIImage = UIImage()
    @IBInspectable var emptyStarImage: UIImage = UIImage()
    
    var currentRating: Float = 0.0
    var starImageViews: [UIImageView] = []

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        // Clear current star array if maxRating changes
        if (starImageViews.count != maxRating) {
            starImageViews.removeAll(keepCapacity: false)
        }
        
        // Set of star array equal to maxRating
        if (starImageViews.count == 0) {
            for index in 0..<maxRating {
                let image = UIImageView(image: emptyStarImage)
                starImageViews.append(image)
                self.addSubview(image)
                image.frame.origin.x = CGFloat(index) * self.frame.width / CGFloat(maxRating)
                image.frame.size.width = 9
                image.frame.size.height = 9
            }
        }
        
        // set full stars based on rating
        var rating = currentRating
        for index in 0..<maxRating {
            if (rating >= 0.75) {
                starImageViews[index].image = emptyStarImage
                rating = rating - 1.0
            }
            else {
                starImageViews[index].image = fullStarImage
            }
        }
        
    }
    
    public func setRating(rating: Float) {
        self.currentRating = rating
        self.setNeedsLayout()
    }
    
    
}
