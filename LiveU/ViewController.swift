//
//  ViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var mainBackground: UIImageView!
    @IBOutlet weak var liveIcon: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        logInButton.layer.cornerRadius = 0.5
        mainBackground.image = #imageLiteral(resourceName: "MainBackground")
        liveIcon.image = #imageLiteral(resourceName: "LiveUIcon")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

