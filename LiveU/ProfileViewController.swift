//
//  ProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var artistProfileView: UIView!
    var profileType: String!
    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let user = currentUser{
            if user.artist == true{
                addSubView(profileType: "artist")
            } else if user.venue == true{
                addSubView(profileType: "venue")
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addSubView(profileType: String) {
        // Declare closure calling functions in the different view controllers setupfunctions
        // Passing the currentUser forward.
        if profileType == "artist" {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let artistProfile = storyboard.instantiateViewController(withIdentifier: "artistProfile")
            artistProfileView.addSubview(artistProfile.view)
            
            artistProfileView.addSubview(artistProfile.view)
        } else if profileType == "venue"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let venueProfile = storyboard.instantiateViewController(withIdentifier: "venueProfile")
            artistProfileView.addSubview(venueProfile.view)
        }
    }
}
