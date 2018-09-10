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
    
    var logInController: LoginViewController?
    var signUpController: SignUpViewController?
    var currentUser: User!
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(withIdentifier: "logIn")
        self.addChildViewController(logIn)
        view.addSubview(logIn.view)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let profileView = segue.destination as! ProfileTabViewController
        let controllerArray = self.childViewControllers
        
        
        if controllerArray[0] is LoginViewController{
            logInController = controllerArray[0] as? LoginViewController
            profileView.currentUser = logInController?.currentUser
   
            
        } else if controllerArray[0] is SignUpViewController {
            signUpController = controllerArray[0] as? SignUpViewController
            profileView.currentUser = signUpController?.currentUser
            
        } else {
            print("Oh no you suck again.")
        }
    }
}
