//
//  VenueProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase

class VenueProfileViewController: UIViewController {
    
    private var ref: DatabaseReference!
    var currentUser:User!

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        
        if let user = currentUser{
            profileImageView.image = #imageLiteral(resourceName: "VenueProfile")
            venueNameLabel.text = user.fullName
            descriptionTextField.text = currentUser.about
        }
        ref = Database.database().reference()
        backgroundView.layer.cornerRadius = 15
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func steup(){
    }
}
