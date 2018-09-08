//
//  ProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var artistProfileView: UIView!
    
    var profileType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let profile = profileType{
            addSubView(profileType: profile)
        }
        
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
