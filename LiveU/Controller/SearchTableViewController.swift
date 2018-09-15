//
//  SearchTableViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/12/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class SearchTableViewController: UITableViewController{
    
    private var searchController = UISearchController(searchResultsController: nil)
    private var ref: DatabaseReference!
    private var posts: [Posts] = []
    var selectedPost: Posts?
    private var currentUser: User!
    var appliedArtist: [String] = []
    var dicArray: [String:[String]] = [:]
    var users: [String] = []
    let locationManager = CLLocationManager()
    
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
        
    }
    
    
    // TableView Functions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        tableView.rowHeight = 247
        
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchTableViewCell else {return tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)}
        
        if currentUser.artist == "true"{
            cell.postImageView.image = #imageLiteral(resourceName: "VenueProfile")
            cell.cellLabelCollection[1].text = posts[indexPath.row].budget
            cell.cellLabelCollection[2].text = posts[indexPath.row].location
        } else if currentUser.venue == "true" {
            cell.postImageView.image = #imageLiteral(resourceName: "Artist Profile")
            cell.cellLabelCollection[1].text = posts[indexPath.row].genre
            cell.cellLabelCollection[2].text = posts[indexPath.row].date
        }
        
        cell.cellLabelCollection[0].text = posts[indexPath.row].title
        
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedPost = posts[indexPath.row]
        
        if currentUser.artist == "true"{
            performSegue(withIdentifier: "gigDetails", sender: self)
        } else if currentUser.venue == "true"{
                        
            let appliedArtistArray = dicArray[posts[indexPath.row].uid]
            if let arr = appliedArtistArray {
                appliedArtist = arr
            }
            self.performSegue(withIdentifier: "toAppliedArtists", sender: self)
        }
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
        checkLocationServices()
        ref = Database.database().reference()
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        
        if currentUser.artist == "true"{
            artistSetup()
        } else if currentUser.venue == "true"{
            venueSetup()
        } else {
            print("Unable to determine UserType")
        }
        
        searchController.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    //TODO: Milestone 3
    func artistSetup(){
        navigationItem.title = "Gigs"
        searchController.searchBar.scopeButtonTitles = ["Location", "Genre"]
        
        ref.child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let data = snapshot.value as? [String: Any] {
                let uid = snapshot.key
                let title = data["title"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let budget = data["budget"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                
                self.posts.append(Posts(uid: uid, title: title, genre: genre, budget: budget, date: date, location: location))
            }
            self.tableView.reloadData()
        }, withCancel: nil)
    }
    
    
    func venueSetup(){
        navigationItem.title = "Artists"
        searchController.searchBar.scopeButtonTitles = ["My Posts", "Artists"]
        ref.child("users").child(currentUser.uid).child("posts").observeSingleEvent(of: .value, with: { (snapshot) in
            if let data = snapshot.value as? [String: Any] {
                for keys in data.keys {
                    self.ref.child("posts").child(keys).observeSingleEvent(of: .value, with: { (snapshot) in
                        if let postsData = snapshot.value as? [String:Any]{
                            let uid = snapshot.key
                            let title = postsData["title"] as? String ?? ""
                            let location = postsData["location"] as? String ?? ""
                            let genre = postsData["genre"] as? String ?? ""
                            let budget = postsData["budget"] as? String ?? ""
                            let date = postsData["date"] as? String ?? ""
                            if let d = postsData["applied"] as? [String:Any] {
                                self.users = []
                                for key in d.keys{
                                    self.users.append(key)
                                }
                                self.dicArray[uid] = self.users
                            }
                            self.posts.append(Posts(uid: uid, title: title, genre: genre, budget: budget, date: date, location: location))
                            self.tableView.reloadData()
                        }
                    }, withCancel: { (error) in
                        print(error.localizedDescription)
                    })
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toAppliedArtists" {
            let appliedView = segue.destination as? AppliedArtistsTableViewController
            appliedView?.appliedArtists = appliedArtist
            
        } else if segue.identifier == "gigDetails" {
            let detailsView = segue.destination as? PostDetailsViewController
            detailsView?.localPost = selectedPost
        }
    }
    
    func locationManagerSetup(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManagerSetup()
            LoMan.checkLocationPermissions(locationManager: locationManager)
        } else {
            //Display alert telling user to turn on location services
        }
    }
}

// Search Controller extension
extension SearchTableViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        
    }
}

// Location Manager extension
extension SearchTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
    
}
