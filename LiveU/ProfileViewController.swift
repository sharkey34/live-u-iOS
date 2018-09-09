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
    
    
    var ref: DatabaseReference!
    var profileType: String?
    var currentUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
              ref = Database.database().reference()
        
        let user = Auth.auth().currentUser?.uid
            self.ref.child("users").child(user!).observeSingleEvent(of: .value, with: { (snapshot) in
                let data = snapshot.value as? NSDictionary
                let email = data?["email"] as? String ?? ""
                let fullName = data?["fullName"] as? String ?? ""
                let artist = data?["artist"] as? Bool ?? false
                let venue = data?["venue"] as? Bool ?? false
                let payPal = data?["payPal"] as? String ?? nil
                let location = data?["location"] as? String ?? nil
                
                
                self.currentUser = User(fullName: fullName, email: email, artist: artist, venue: venue, payPal: payPal, profileImage: nil, location: location)
                
                if self.currentUser?.artist == true{
                    self.profileType = "artist"
                } else {
                    self.profileType = "venue"
                }
                if let profile = self.profileType{
                    self.addSubView(profileType: profile)
                }
                
            })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("tapped")
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
    func addSubView(profileType: String){
        
        if profileType == "artist" {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let artistProfile = storyboard.instantiateViewController(withIdentifier: "artistProfile")
            
            artistProfileView.addSubview(artistProfile.view)
            
            
        } else if profileType == "venue"{
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            
            let venueProfile = storyboard.instantiateViewController(withIdentifier: "venueProfile")
            
            artistProfileView.addSubview(venueProfile.view)
        }
    }
    
}
