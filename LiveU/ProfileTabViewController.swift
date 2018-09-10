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
        if let user = currentUser{
            if user.artist == true{
                let artistProfileVIew = ArtistProfileViewController()
                artistProfileVIew.title = "artist"
                artistProfileVIew.currentUser = currentUser
                
                artistProfileVIew.tabBarItem = UITabBarItem(title: "Profile", image: #imageLiteral(resourceName: "ProfileIcon"), selectedImage: #imageLiteral(resourceName: "ProfileIcon"))
                
                
                let addView = AddViewController()
                addView.title = "add"
                addView.tabBarItem = UITabBarItem(title: "Add", image: #imageLiteral(resourceName: "AddIcon"), selectedImage: #imageLiteral(resourceName: "AddIcon"))
                
                self.viewControllers = [artistProfileVIew,addView]
                
            } else if user.venue == true{
                let venueProfileView = VenueProfileViewController()
                venueProfileView.title = "venue"
                
                let addView = AddViewController()
                addView.title = "add"
            }
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    func addSubView(profileType: String) {
        // Declare closure calling functions in the different view controllers setupfunctions
        // Passing the currentUser forward.
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
