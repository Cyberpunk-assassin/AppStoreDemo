//
//  ViewManager.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class ViewManager: NSObject {
    
    
    class var sharedViewManager: ViewManager {
        struct Static {
            static var onceToken: dispatch_once_t = 0
            static var instance: ViewManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ViewManager()
        }
        return Static.instance!
    }
    
    func getViewController() -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewControllerWithIdentifier("ViewController") as! ViewController
        return vc
        
    }
        
   
}
