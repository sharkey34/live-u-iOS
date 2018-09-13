//
//  AddViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/10/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var textFieldCollection: [UITextField]!
    @IBOutlet var imageViewCollection: [UIImageView]!
    
    private var currentUser: User!
    private var ref: DatabaseReference!
    private var postDate: String!
    private var datePicker = UIDatePicker()
    private var fullAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting initial textField date.
        let format = DateFormatter()
        format.locale = Locale.current
        format.dateFormat = "EEEE, MMMM dd, yyyy"
        let dateString = format.string(from: datePicker.date)
        postDate = dateString
        
        textFieldCollection[3].text = postDate
        setUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUp(){
        ref  = Database.database().reference()
        
        // setting up datePicker
        let date = Date()
        datePicker.datePickerMode = .date
        datePicker.minimumDate = date
        
        // Setting date maximum
        let calendar = NSCalendar(calendarIdentifier: .gregorian)
        var components = DateComponents()
        components.year = +1
        datePicker.maximumDate = calendar?.date(byAdding: components, to: date, options: NSCalendar.Options(rawValue: 0))
        
        // Adding valueChanged function and the datePicker to the textFields inputView.
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        textFieldCollection[3].inputView = datePicker
        
        // Adding gradiant layer to teh view.
        let gradiantLayer = CAGradientLayer()
        gradiantLayer.colors = [UIColor.white.cgColor, UIColor.lightGray.cgColor]
        gradiantLayer.frame = view.frame
        
        view.layer.insertSublayer(gradiantLayer, at: 0)
    }
    
    // Post tectField validation.
    func validatePost() -> Bool{
        var validPost = true
        
        for field in textFieldCollection.enumerated(){
            if field.element.text?.isEmpty == true{
                imageViewCollection[field.offset].image = #imageLiteral(resourceName: "ExclamationPoint")
            }
        }
        
        for image in imageViewCollection{
            if image.image != nil{
                validPost = false
            }
        }
        
        return validPost
    }
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        let valid = validatePost()
        
        if valid {
            currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
            
            fullAddress = textFieldCollection[4].text! + " " + textFieldCollection[5].text! + " " + textFieldCollection[6].text!
            
            //TODO: Add completion block to display a message to the user when info is saved corrrectly.
            
            // Getting the reference key for the post adding the post to posts and the user who created it at the same time.
            let key = ref.child("posts").childByAutoId().key
            let postArray = ["title": textFieldCollection[0].text!, "genre":textFieldCollection[1].text!,"budget":textFieldCollection[2].text!,"date":postDate, "location":fullAddress, "creator": currentUser.uid] as [String : Any]
            
            let userArray =  ["title": textFieldCollection[0].text!, "genre":textFieldCollection[1].text!,"budget":textFieldCollection[2].text!,"date":postDate, "location":fullAddress] as [String:Any]
            
            let childUpdates = ["/posts/\(key)": postArray,
                                "/users/\(currentUser.uid)/posts/\(key)/": userArray]
            ref.updateChildValues(childUpdates) {
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                } else {
                    print("Data saved successfully!")
                    for field in self.textFieldCollection{
                        field.text = nil
                    }
                }
            }
        } else {
            print("invalid entry.")
        }
    }
    
    // DatePicker Callbacks
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        
        let format = DateFormatter()
        format.locale = Locale.current
        format.dateFormat = "EEEE, MMMM dd, yyyy"
        let dateString = format.string(from: datePicker.date)
        postDate = dateString
        
        textFieldCollection[3].text = postDate
    }
    
    // TextField Callbacks
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // TODO: Possible checks each time a text field is left.
        
        switch textField.tag {
        case 0:
            textFieldCollection[0].resignFirstResponder()
            textFieldCollection[1].becomeFirstResponder()
        case 1:
            textFieldCollection[1].resignFirstResponder()
            textFieldCollection[2].becomeFirstResponder()
        case 2:
            textFieldCollection[2].resignFirstResponder()
            textFieldCollection[3].becomeFirstResponder()
        case 3:
            textFieldCollection[3].resignFirstResponder()
            textFieldCollection[4].becomeFirstResponder()
        case 4:
            textFieldCollection[4].resignFirstResponder()
            textFieldCollection[5].becomeFirstResponder()
        case 5:
            textFieldCollection[5].resignFirstResponder()
        default:
            print("Tag out of bounds.")
        }
        
        
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for field in textFieldCollection{
            field.resignFirstResponder()
        }
    }
    
    
}
