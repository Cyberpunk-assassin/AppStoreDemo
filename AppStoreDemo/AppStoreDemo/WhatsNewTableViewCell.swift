//
//  WhatsNewTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class WhatsNewTableViewCell: UITableViewCell {
    var refreshCell:(() -> Void)? = nil
    var textViewDirtyCount = 0
    var originalText : String!

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var versionDescrTextView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(title:String,releaseDate:String, desc : String){
        self.titleLabel.text = title
        self.releaseDateLabel.text = releaseDate
        var attributedString: NSMutableAttributedString!
        self.originalText = desc
        if desc.utf16.count > 120 {
            attributedString = desc.trimText(120, appendWith: "more")
            self.versionDescrTextView.attributedText = attributedString
        } else {
            self.versionDescrTextView.attributedText = nil
            self.versionDescrTextView.text = desc
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
        self.versionDescrTextView.attributedText = nil
        self.versionDescrTextView.text = self.originalText
        self.textViewDidChange(self.versionDescrTextView)
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
