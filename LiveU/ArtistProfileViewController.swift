//
//  ArtistProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//
// Search icon by freepik from www.flaticon.com
// Add icon by dimitri13 from www.flaticon.com
// Profile icon by Gregor Cresnar from www.flaticon.com


import UIKit
import FirebaseAuth
import Firebase

class ArtistProfileViewController: UIViewController {
    
    
    var ref: DatabaseReference!
    var currentUser:User!
    
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var schoolLabelName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var aboutTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        
        if let user = currentUser{
            profileImage.image = #imageLiteral(resourceName: "Artist Profile")
            artistNameLabel.text = user.fullName
        }
        
        ref = Database.database().reference()
        
        backGroundView.layer.cornerRadius = 15
        aboutView.layer.cornerRadius = 15
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    func setup(){
    }
}
