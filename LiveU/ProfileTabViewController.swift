//
//  ProfileTabViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/10/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ProfileTabViewController: UITabBarController {
    var profileType: String!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        print(currentUser.fullName)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addSubView(profileType: String) {
        if profileType == "artist" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let artistProfile = storyboard.instantiateViewController(withIdentifier: "artistProfile")
            self.view.addSubview(artistProfile.view)

        } else if profileType == "venue"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let venueProfile = storyboard.instantiateViewController(withIdentifier: "venueProfile")
            self.view.addSubview(venueProfile.view)
        }
    }
}
