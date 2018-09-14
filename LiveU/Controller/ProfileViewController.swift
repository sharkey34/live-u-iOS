//
//  ProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/10/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    var currentUser: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        
        if let user = currentUser{
            if user.artist == "true"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let artistPro = storyboard.instantiateViewController(withIdentifier: "artistProfile")
                self.addChildViewController(artistPro)
                self.view.addSubview(artistPro.view)
                                
            } else if user.venue == "true"{
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let venuePro = storyboard.instantiateViewController(withIdentifier: "venueProfile")
                self.addChildViewController(venuePro)
                self.view.addSubview(venuePro.view)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarItem.image = #imageLiteral(resourceName: "ProfileIcon")
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        tabBarItem.image = #imageLiteral(resourceName: "ProfileIconSelected")
        UIApplication.shared.statusBarStyle = .default
    }

}
