//
//  CommentsReviewTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class CommentsReviewTableViewCell: UITableViewCell {
    var refreshCell:(() -> Void)? = nil
    var textViewDirtyCount = 0
    var originalText : String!
    
    @IBOutlet weak var commentHeading: UILabel!
    
    @IBOutlet weak var ratingView: StarRatingView!
    
    @IBOutlet weak var userDetails: UILabel!
    
    @IBOutlet weak var textView: UITextView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func configure(reviews : ReviewsModel, number : Int) {
        self.commentHeading.text = "\(number). \(reviews.commentHeader)"
        self.ratingView.setRating(Float(reviews.rating)!)
        self.userDetails.text = reviews.userName
        var attributedString: NSMutableAttributedString!
        self.originalText = reviews.comment
        if reviews.comment.utf16.count > 120 {
            attributedString = reviews.comment.trimText(120, appendWith: "more")
            self.textView.attributedText = attributedString
        } else {
            self.textView.attributedText = nil
            self.textView.text = reviews.comment
        }
        
    }
    
    // MARK: - UITextViewDelegate
    func textViewDidChange(textView: UITextView) {
        textViewDirtyCount += 1
        performSelector(#selector(DescriptionTableViewCell.queuedTextVewDidChange),
                        withObject: nil,
                        afterDelay: 0) // Wait until typing stopped
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        textViewDirtyCount = 0 // initialize queuedTextVewDidChange
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        textViewDirtyCount = -1 // prevent any further queuedTextVewDidChange
    }
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        self.textView.attributedText = nil
        self.textView.text = self.originalText
        self.textViewDidChange(self.textView)
        return true
    }
    
    func queuedTextVewDidChange() {
        if textViewDirtyCount > 0 {
            textViewDirtyCount -= 1
            if 0 == textViewDirtyCount, let refreshCell = refreshCell {
                refreshCell()
            }
        }
    }
    
    
}
