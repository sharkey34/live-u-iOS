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
    var currentUser: User!
    
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
        var artist = ""
        var venue = ""
        var about = ""
        
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
                
                //MARK: Change back to bool when encoding is figured out.
                
                if valid == 5 {
                    
                    print("All are valid.")
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if let _ = result{
                            
                            if self.artistVenueControl.selectedSegmentIndex == 0 {
                                artist = "true"
                                venue = "false"
                                about = "\(fullName) is a dedicated and talented musician attending Full Sail University. Her dream to make a living doing what she loves drove her to the Music Business program with the intent to learn more about the business and further her career. Being a full-time student \(fullName) often has trouble finding the time to contact venues all over town to see if she can play. \(fullName) is looking for a way to focus on school while getting the opportunity to make money practicing her craft."
                            } else {
                                venue = "true"
                                artist = "false"
                                about = "\(fullName) is an established local business that prides itself on supporting the local community while giving their customers the best experience available."
                            }
                            
                            
                            self.ref.child("users").child((result?.user.uid)!).setValue(["email":email, "fullName": fullName, "artist":artist, "venue": venue, "city":city, "state": state])
                            
                            
                            let user = Auth.auth().currentUser?.uid
                            
                            if let uid = user {
                                self.currentUser = User(uid: uid,fullName: fullName, email: email, about: about, artist: artist, venue: venue, payPal: nil, profileImage: nil, location: nil, posts: nil)
                                    
                                    UserDefaults.standard.set(currentUser: self.currentUser, forKey: "currentUser")
                                    self.parent?.performSegue(withIdentifier: "toProfile", sender: sender)
                        
                            } else {
                                print("uid was nil")
                            }
                            
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        switch textField.tag {
        case 0:
            textField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case 1:
            textField.resignFirstResponder()
            fullNameTextField.becomeFirstResponder()
        case 2:
            textField.resignFirstResponder()
            cityTextField.becomeFirstResponder()
        case 3:
            textField.resignFirstResponder()
            stateTextField.becomeFirstResponder()
        case 4:
            textField.resignFirstResponder()
            artistVenueControl.becomeFirstResponder()
        default:
            print("Textfield switch failed.")
        }
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        fullNameTextField.resignFirstResponder()
        cityTextField.resignFirstResponder()
        stateTextField.resignFirstResponder()
    }
    
}
