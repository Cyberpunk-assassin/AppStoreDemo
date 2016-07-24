//
//  StringUtils.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 24/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import Foundation
import UIKit

extension String {
    public func convertDateFormater() -> String {
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let date = dateFormatter.dateFromString(self)
        
        dateFormatter.dateFormat = "dd MMM yyyy "
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        let timeStamp = dateFormatter.stringFromDate(date!)
        
        return timeStamp
    }
    
    public func trimText(length : Int, appendWith word : String) -> NSMutableAttributedString {
        var attributedString: NSMutableAttributedString!
        
        var abc : String =  (self as NSString).substringWithRange(NSRange(location: 0, length: length))
        abc += "...\(word)"
        let attribs = [NSForegroundColorAttributeName: UIColor.darkGrayColor(), NSFontAttributeName: UIFont.systemFontOfSize(14.0)]
        attributedString = NSMutableAttributedString(string: abc, attributes: attribs)
        attributedString.addAttribute(NSLinkAttributeName, value: "...\(word)", range: NSRange(location: length, length: 3+word.characters.count))
        return attributedString
        
    }
}
