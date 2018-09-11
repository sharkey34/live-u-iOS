//
//  AddViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/10/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase

class AddViewController: UIViewController {

    
    @IBOutlet var textFieldCollection: [UITextField]!
    
    private var currentUser: User!
    private var ref: DatabaseReference!
    private var postDate: String!
    private var datePicker = UIDatePicker()
    private var fullAddress: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
   @objc func datePickerValueChanged(_ sender: UIDatePicker) {
    
    let format = DateFormatter()
    format.locale = Locale.current
    format.dateFormat = "EEEE, MMMM dd, yyyy"
    let dateString = format.string(from: datePicker.date)
    postDate = dateString
    
    textFieldCollection[2].text = postDate
    }
    
    
    @IBAction func postButtonPressed(_ sender: UIButton) {
        
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        
        fullAddress = "\(String(describing: textFieldCollection[4].text)) \(String(describing: textFieldCollection[5].text)), \(textFieldCollection[6])"
        
        ref.child("users").child(currentUser.uid).updateChildValues(["posts": ["title": textFieldCollection[0].text, "genre":textFieldCollection[1].text,"budget":textFieldCollection[2].text,"date":postDate, "location":fullAddress]])

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
}
