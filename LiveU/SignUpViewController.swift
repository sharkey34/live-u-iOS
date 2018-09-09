//
//  SignUpViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/6/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//
// Exclamation icon from by Pixel Buddha from www.flaticon.com


import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController, UITextFieldDelegate {
    private var ref: DatabaseReference!
    var currentUser: User?
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailExclamation: UIImageView!
    @IBOutlet weak var passwordExclamation: UIImageView!
    @IBOutlet weak var artistVenueControl: UISegmentedControl!
    @IBOutlet weak var stateTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var fullNameTextField: UITextField!
    @IBOutlet weak var cityExclamation: UIImageView!
    @IBOutlet weak var stateExclamation: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        ref = Database.database().reference()
        
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradiantLayer.frame = view.frame
        
        view.layer.insertSublayer(gradiantLayer, at: 0)
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func SignUpPressed(_ sender: UIButton) {
        
        var valid = 3
        var artist = false
        var venue = false
        
        guard let email = emailTextField.text, let password = passwordTextField.text, let fullName = fullNameTextField.text, let city = cityTextField.text, let state = stateTextField.text else {return}
        
        if email.isEmpty == false, password.isEmpty == false, fullName.isEmpty == false, city.isEmpty == false, state.isEmpty == false {
            
            do {
                // Using REGEX to validate email.
                let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                    , options: .caseInsensitive)
                
                if regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil {
                    print("Valid email found.")
                    valid += 1
                } else {
                    emailExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
                }
                
                // Password Validation
                if password.count >= 8 {
                    print("Valid Password entered.")
                    valid += 1
                } else {
                    passwordExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
                }
                
                if artistVenueControl.selectedSegmentIndex == 0 {
                    artist = true
                } else {
                    venue = true
                }
                
                if valid == 5 {
                    
                    print("All are valid.")
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if let _ = result{
                            
                            self.ref.child("users").child((result?.user.uid)!).setValue(["email":email, "fullName": fullName, "artist":artist, "venue": venue, "city":city, "state": state])
                            
                            self.parent?.performSegue(withIdentifier: "toProfile", sender: sender)
                            
                        } else {
                            if let err = error{
                                print(err.localizedDescription)
                            }
                        }
                    }
                }
            } catch{
                print(error.localizedDescription)
            }
            
        } else {
            print("Please don't leave Fields blank.")
            passwordExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
            emailExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
        }
    }
    
    @IBAction func CancelPressed(_ sender: UIButton) {
        
        let superView = parent!
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let logIn = storyboard.instantiateViewController(withIdentifier: "logIn")
        superView.addChildViewController(logIn)
        superView.view.addSubview(logIn.view)
    }
    
    
}
