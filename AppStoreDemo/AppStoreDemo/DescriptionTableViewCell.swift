//
//  DescriptionTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: UITableViewCell, UITextViewDelegate {
    var refreshCell:(() -> Void)? = nil
    var textViewDirtyCount = 0
    var originalText : String!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descTxtView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        descTxtView.delegate = self
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title:String, desc : String){
        self.titleLabel.text = title
        var attributedString: NSMutableAttributedString!
        self.originalText = desc
        if desc.utf16.count > 120 {
            attributedString = desc.trimText(120, appendWith: "more")
            self.descTxtView.attributedText = attributedString
        } else {
            self.descTxtView.attributedText = nil
            self.descTxtView.text = desc
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
        self.descTxtView.attributedText = nil
        self.descTxtView.text = self.originalText
        self.textViewDidChange(self.descTxtView)
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
