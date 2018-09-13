//
//  MainViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(withIdentifier: "logIn")
        self.addChildViewController(logIn)
        view.addSubview(logIn.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
