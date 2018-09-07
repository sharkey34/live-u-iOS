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

class SignUpViewController: UIViewController {
    private var ref: DatabaseReference!

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailExclamation: UIImageView!
    @IBOutlet weak var passwordExclamation: UIImageView!
    
    @IBOutlet weak var artistVenueSegment: UISegmentedControl!
    
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
        
        var validEmail: Bool?
        var validPassword: Bool?
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        
        if email.isEmpty == false, password.isEmpty == false {
            
            do {
                let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
                    , options: .caseInsensitive)
                
                if regex.firstMatch(in: email, options: [], range: NSRange(location: 0, length: email.count)) != nil {
                    print("Valid email found.")
                    validEmail = true
                } else {
                    emailExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
                    validEmail = false
                }
                
                if password.count >= 8 {
                    print("Valid Password entered.")
                    validPassword = true
                } else {
                    passwordExclamation.image = #imageLiteral(resourceName: "ExclamationPoint")
                    validPassword = false
                }
                
                if validPassword == true && validEmail == true{
                    
                    print("Both are valid.")
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if let _ = result{
                            
                            self.ref.child("users").childByAutoId().setValue(["email":email, "password": password])
                            
                            self.emailTextField.text = nil
                            self.passwordTextField.text = nil
                            
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
        dismiss(animated: true, completion: nil)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
