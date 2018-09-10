//
//  User.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import Foundation
import UIKit

class User:  NSObject, NSCoding {

    
    var fullName: String
    var email: String
    var artist: String!
    var venue: String!
    var payPal: String!
    var profileImage: UIImage!
    var location: String!
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(fullName, forKey: "fullName")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(artist, forKey: "artist")
        aCoder.encode(venue, forKey: "venue")
        aCoder.encode(payPal, forKey: "payPal")
        aCoder.encode(profileImage, forKey: "profileImage")
        aCoder.encode(location, forKey: "location")
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.fullName = (aDecoder.decodeObject(forKey: "fullName") as? String)!
        self.email = (aDecoder.decodeObject(forKey: "email") as? String)!
        self.artist = aDecoder.decodeObject(forKey: "artist") as! String
        self.venue = aDecoder.decodeObject(forKey: "venue") as! String
        self.payPal = (aDecoder.decodeObject(forKey: "payPal") as? String)
        self.profileImage = (aDecoder.decodeObject(forKey: "profileImage") as? UIImage)
        self.location = (aDecoder.decodeObject(forKey: "location") as? String)
    }
    
    init(fullName: String, email: String, artist: String?, venue: String?, payPal: String?, profileImage: UIImage?, location: String?) {
        
        self.fullName = fullName
        self.email = email
        self.artist = artist
        self.venue = venue
        self.payPal = payPal
        self.profileImage = profileImage
        self.location = location
        
    }
}
