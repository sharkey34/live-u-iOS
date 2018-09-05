//
//  ViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/4/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController {
    var ref: DatabaseReference!
    @IBOutlet weak var mainBackground: UIImageView!
    @IBOutlet weak var liveIcon: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        mainBackground.image = #imageLiteral(resourceName: "MainBackground")
        liveIcon.image = #imageLiteral(resourceName: "LiveUIcon")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

