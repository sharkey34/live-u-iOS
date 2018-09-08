//
//  LoginViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    private var ref: DatabaseReference!
    @IBOutlet weak var mainBackground: UIImageView!
    @IBOutlet weak var liveIcon: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    

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
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        

        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            
            if let user = result{
                print("user \(user) found")
                
                // TODO: Create a user from the found users data.
                   // Check if business or Artist
                
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                
                self.performSegue(withIdentifier: "logInSegue", sender: sender)
                
            } else {
                if let err = error{
                    print(err)
                }
            }
        }
    }
    @IBAction func signInPressed(_ sender: UIButton) {
        
        let superView = parent!

        self.willMove(toParentViewController: nil)

        self.view.removeFromSuperview()

        self.removeFromParentViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let signUp = storyboard.instantiateViewController(withIdentifier: "signUp")
        
        superView.addChildViewController(signUp)

        superView.view.addSubview(signUp.view)
        
    }
}

