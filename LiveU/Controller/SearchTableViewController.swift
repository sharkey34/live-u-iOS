//
//  SearchTableViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/12/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase

class SearchTableViewController: UITableViewController,UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    var searchController = UISearchController(searchResultsController: nil)
    var ref: DatabaseReference!
    var localPosts: [Posts] = []
    var selectedPost: Posts?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        ref.child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let data = snapshot.value as? [String: Any] {
                let uid = snapshot.key
                let title = data["title"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let budget = data["budget"] as? String ?? ""
                let date = data["date"] as? String ?? ""
 
                print(date)
                
                self.localPosts.append(Posts(uid: uid, title: title, genre: genre, budget: budget, date: date, location: location))
            }
            self.tableView.reloadData()
        }, withCancel: nil)
        
        
        setUp()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


    // TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 247
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)}
        
        cell.VenueImageView.image = #imageLiteral(resourceName: "VenueProfile")
        cell.cellLabelCollection[0].text = localPosts[indexPath.row].title
        cell.cellLabelCollection[1].text = localPosts[indexPath.row].budget
        cell.cellLabelCollection[2].text = localPosts[indexPath.row].location
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = localPosts[indexPath.row]
        performSegue(withIdentifier: "details", sender: self)
    }
    

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

    func setUp(){
        ref = Database.database().reference()
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Location", "Genre"]

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.title = "Gigs"
        
    }
    
    // UISearchBar Callbacks
    
    //TODO: Milestone 3
    
    func updateSearchResults(for searchController: UISearchController) {
        

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailsView = segue.destination as? PostDetailsViewController
        detailsView?.localPost = selectedPost
    }
    
    

}
