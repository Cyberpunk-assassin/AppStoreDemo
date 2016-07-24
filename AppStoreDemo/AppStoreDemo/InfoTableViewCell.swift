//
//  InfoTableViewCell.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {

    @IBOutlet weak var devLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var vsLabel: UILabel!
    @IBOutlet weak var compatibilityLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func configure(detail : Details){
        self.devLabel.text = detail.artistName
        self.categoryLabel.text = detail.primaryGenreName
        self.vsLabel.text = detail.version
        self.compatibilityLabel.text = detail.compatibility
        self.languageLabel.text = detail.language.joinWithSeparator(", ")
    }
}
