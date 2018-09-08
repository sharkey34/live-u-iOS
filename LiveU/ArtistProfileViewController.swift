//
//  ArtistProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//
// Search icon by freepik from www.flaticon.com
// Add icon by dimitri13 from www.flaticon.com
// Profile icon by Gregor Cresnar from www.flaticon.com


import UIKit

class ArtistProfileViewController: UIViewController {
    @IBOutlet weak var backGroundView: UIView!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var aboutView: UIView!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var schoolLabelName: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var aboutTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        backGroundView.layer.cornerRadius = 0.5
        aboutView.layer.cornerRadius = 0.5
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
