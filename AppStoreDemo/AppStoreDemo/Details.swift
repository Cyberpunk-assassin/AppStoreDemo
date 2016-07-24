//
//  Details.swift
//  AppStoreDemo
//
//  Created by Ishan Sarangi on 23/07/16.
//  Copyright © 2016 ishan. All rights reserved.
//

import UIKit

class Details: NSObject {
    
    var screenshotUrls : [String]!
    var ipadScreenshotUrls : [String]!
    var artworkUrl60 : String!
    var kind : String!
    var trackCensoredName : String!
    var language : [String]!
    var trackContentRating : String!
    var averageUserRating : Int!
    var userRatingCountForCurrentVersion : Int!
    var version : String!
    var descriptions : String!
    var artistId : Int!
    var compatibility : String!
    var artistName : String!
    var formattedPrice : String!
    var trackName : String!
    var trackId : Int!
    var currentVersionReleaseDate : String!
    var primaryGenreName : String!
    var releaseNotes : String!
    var sellerName : String!
    
    override init() {
        super.init()
    }

}
