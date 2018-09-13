//
//  SearchViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/13/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        

        if currentUser?.artist == "true"{

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let artistSearch = storyboard.instantiateViewController(withIdentifier: "artistSearch")
            self.addChildViewController(artistSearch)
            navigationController?.setViewControllers([artistSearch], animated: true)
            view.addSubview(artistSearch.view)
            
        } else {
            
        }
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
