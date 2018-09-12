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
    var fakeData = ["fish","cow","dumb"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setUp()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    // TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        tableView.rowHeight = 247
        return fakeData.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)}
        
        cell.imageView?.image = #imageLiteral(resourceName: "VenueProfile")
    
        
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

    func setUp(){
        ref = Database.database().reference()
        
        searchController.delegate = self
        searchController.searchBar.text = "Search Gigs"
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        searchController.searchBar.scopeButtonTitles = ["Location", "Genre"]

        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.title = "Gigs"
    
    }
    
    // UISearchBar Callbacks
    
    func updateSearchResults(for searchController: UISearchController) {
        

    }

}
