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

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    private var ref: DatabaseReference!
    var currentUser: User!
    
    
    @IBOutlet weak var mainBackground: UIImageView!
    @IBOutlet weak var liveIcon: UIImageView!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordImageView: UIImageView!
    @IBOutlet weak var emailImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        
        guard let email = emailTextField.text, let password = passwordTextField.text else {return}
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let _ = result{                
                // TODO: Create a user from the found users data.
                // Check if business or Artist
                
                self.emailTextField.text = nil
                self.passwordTextField.text = nil
                
                NotificationCenter.default.removeObserver(self)
                let user = Auth.auth().currentUser?.uid
                self.ref.child("users").child(user!).observeSingleEvent(of: .value, with: { (snapshot) in
                    let data = snapshot.value as? NSDictionary
                    let email = data?["email"] as? String ?? ""
                    let fullName = data?["fullName"] as? String ?? ""
                    let artist = data?["artist"] as? String ?? nil
                    let venue = data?["venue"] as? String ?? nil
                    let payPal = data?["payPal"] as? String ?? nil
                    let location = data?["location"] as? String ?? nil
                    self.currentUser = User(fullName: fullName, email: email, artist: artist, venue: venue, payPal: payPal, profileImage: nil, location: location)
                    
                    UserDefaults.standard.set(currentUser: self.currentUser, forKey: "currentUser")
                
                
                    self.parent?.performSegue(withIdentifier: "toProfile", sender: sender)
                })
          
            } else {
                if let err = error{
                    print(err.localizedDescription)
                }
            }
        }
    }
    @IBAction func signInPressed(_ sender: UIButton) {
        // Removing view from Parent.
        let superView = parent!
        self.willMove(toParentViewController: nil)
        self.view.removeFromSuperview()
        self.removeFromParentViewController()
        
        // Adding subView to MainViewController
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let signUp = storyboard.instantiateViewController(withIdentifier: "signUp")
        superView.addChildViewController(signUp)
        superView.view.addSubview(signUp.view)
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField.tag {
        case 0:
            emailTextField.resignFirstResponder()
            passwordTextField.becomeFirstResponder()
        case 1:
            passwordTextField.resignFirstResponder()
        default:
            print("Wrong keyboard tag.")
        }
        return true
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        
    }
    
    @objc func keyboardChange(note: Notification){
        
        if note.name == Notification.Name.UIKeyboardWillHide || note.name == Notification.Name.UIKeyboardDidChangeFrame{
            view.frame.origin.y = 0
        } else {
            view.frame.origin.y = -100
        }
    }
    
    func setup(){
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        ref = Database.database().reference()
        
        logInButton.layer.cornerRadius = 0.5
        mainBackground.image = #imageLiteral(resourceName: "MainBackground")
        liveIcon.image = #imageLiteral(resourceName: "LiveUIcon")
        
        subscribeUnsubscribe(bool: true)
    }
    
    func subscribeUnsubscribe(bool: Bool){
        
        
        if bool == true {
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(note:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(note:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardChange(note:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)
        } else {
            NotificationCenter.default.removeObserver(self)
        }
    }
}
