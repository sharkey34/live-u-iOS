//
//  MainViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let logInViewController = storyboard.instantiateViewController(withIdentifier: "logIn") as! LoginViewController

        self.view.addSubview(logInViewController.view)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
