//
//  PostDetailsViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/12/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase

class PostDetailsViewController: UIViewController {
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet var labelCollection: [UILabel]!
    
    var ref: DatabaseReference!
    var localPost: Posts!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        
        postImageView.image = #imageLiteral(resourceName: "VenueProfile")
        
        labelCollection[0].text = localPost.title
        labelCollection[1].text = localPost.date
        labelCollection[2].text = localPost.genre
        labelCollection[3].text = localPost.budget
        labelCollection[4].text = localPost.location
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func applyButtonSelected(_ sender: UIButton) {
        
        // TODO: Save Correctly
        if let currentUser = UserDefaults.standard.currentUser(forKey: "currentUser") {

            
            ref.child("posts").child(localPost.uid).child("applied").updateChildValues([currentUser.uid: currentUser.fullName])
            ref.child("users").child(currentUser.uid).child("applied").updateChildValues([localPost.uid: localPost.title])
            
        }
    }
}
