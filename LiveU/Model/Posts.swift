//
//  Posts.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/12/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import Foundation

class Posts {
    
    var uid: String
    var title: String
    var genre: String
    var budget: String
    var date : String
    var location: String
    
    
    init(uid: String, title: String, genre: String, budget: String, date: String, location: String) {
        
        self.uid = uid
        self.title = title
        self.genre = genre
        self.budget = budget
        self.date = date
        self.location = location
    }
    
    
}
