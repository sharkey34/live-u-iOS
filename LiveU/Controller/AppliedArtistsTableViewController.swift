//
//  AppliedArtistsTableViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/14/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase

class AppliedArtistsTableViewController: UITableViewController {
    private var ref: DatabaseReference?
    var appliedArtists: [String] = []
    private var artistArray: [User] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 267
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Applied Artists"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return artistArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AppliedArtistTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)}
        
        
        cell.fullNameLabel.text = artistArray[indexPath.row].fullName
        cell.artistImage.image = #imageLiteral(resourceName: "Artist Profile")
        cell.emailLabel.text = artistArray[indexPath.row].email
        
        let city = artistArray[indexPath.row].location.split(separator: ",")
        let loc: String = city[1] + ", " + city[2]
        
        cell.locationLabel.text = loc
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    func setup(){
        ref = Database.database().reference()
        for user in appliedArtists {
            ref?.child("users").child(user).observeSingleEvent(of: .value, with: { (snapshot) in
                if let data = snapshot.value as? [String:Any]{
                    let uid = user
                    let fullName = data["fullName"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let about = data["about"] as? String ?? ""
                    let artist = data["artist"] as? String ?? ""
                    let venue = data["venue"] as? String ?? ""
                    let payPal = data["payPal"] as? String ?? ""
                    let location = data["location"] as? String ?? ""
                    let posts = data["posts"] as? [String] ?? nil
                    self.artistArray.append(User(uid: uid, fullName: fullName, email: email, about: about, artist: artist, venue: venue, payPal: payPal, profileImage: nil, location: location, posts: posts, distance: nil))
                    self.tableView.reloadData()
                }
            }, withCancel: { (error) in
                print(error.localizedDescription)
            })
        }
    }
}
