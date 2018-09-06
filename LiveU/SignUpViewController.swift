//
//  SignUpViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/6/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SignUpViewController: UIViewController {

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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
