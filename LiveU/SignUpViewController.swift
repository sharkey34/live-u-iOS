//
//  SignUpViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/6/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
                            print("No valid email was found.")
                            validEmail = false
                        }
        
                        if password.count >= 8 {
                            print("Valid Password entered.")
                            validPassword = true
                        } else {
                            print("Your password must be 8 characters or longer.")
                            validPassword = false
                        }
        
                        if validPassword == true && validEmail == true{
                            
                            Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                                //TODO
                            }
                        }
        
                    } catch{
                        print(error.localizedDescription)
                    }
        
                } else {
                    print("Please don't leave Fields blank.")
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
