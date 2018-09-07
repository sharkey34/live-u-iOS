//
//  User.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import Foundation
import UIKit

class User {
    
    var fullName: String
    var email: String
    var artist: Bool!
    var venue: Bool!
    var payPal: String!
    var profileImage: UIImage!
    var location: String!
    
    
    init(fullName: String, email: String, artist: Bool?, venue: Bool?, payPal: String?, profileImage: UIImage?, location: String?) {
        
        self.fullName = fullName
        self.email = email
        self.artist = artist
        self.venue = venue
        self.payPal = payPal
        self.profileImage = profileImage
        self.location = location
        
    }
}
