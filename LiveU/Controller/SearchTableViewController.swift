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
import MapKit

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
    var geocoder = CLGeocoder()
    var userLoc: CLLocation?
    
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
                cell.cellLabelCollection[2].text = posts[indexPath.row].distance.description
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
    
    //TODO: Milestone 3
    func artistSetup(){
        navigationItem.title = "Gigs"
        // Get an array of distances from the users current location and sort
        
        searchController.searchBar.scopeButtonTitles = ["Location", "Genre"]
        
        ref.child("posts").observe(.childAdded, with: { (snapshot) in
            
            if let data = snapshot.value as? [String: Any] {
                let uid = snapshot.key
                let title = data["title"] as? String ?? ""
                let genre = data["genre"] as? String ?? ""
                let location = data["location"] as? String ?? ""
                let budget = data["budget"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                let lat = data["lat"] as? Double ?? nil
                let long = data["long"] as? Double ?? nil
                
                self.posts.append(Posts(uid: uid, title: title, genre: genre, budget: budget, date: date, location: location, distance: nil, lat: lat, long:long))
            }
            self.sortPosts()
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
                            let lat = postsData["lat"] as? Double ?? nil
                            let long = postsData["long"] as? Double ?? nil
                            if let d = postsData["applied"] as? [String:Any] {
                                self.users = []
                                for key in d.keys{
                                    self.users.append(key)
                                }
                                self.dicArray[uid] = self.users
                            }
                            
                            self.posts.append(Posts(uid: uid, title: title, genre: genre, budget: budget, date: date, location: location, distance: nil, lat: lat, long:long))
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
        searchController.searchBar.delegate = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.definesPresentationContext = true
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    // Location Manger Functions
    func checkLocationPermissions(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // logic here
            print("updating location")
            locationManager.startUpdatingLocation()
            break
        case .authorizedAlways:
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            // Let user know about possible parental restrictions
            break
        case . denied:
            // Display alert telling the user to authorize permissions
            break
        }
    }
    
    func locationManagerSetup(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.delegate = self
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManagerSetup()
            checkLocationPermissions()
        } else {
            //Display alert telling user to turn on location services
        }
    }
    func sortPosts(){
        var sortedArray: [Posts] = []
        let formatter = MKDistanceFormatter()
        formatter.units = MKDistanceFormatterUnits.imperial
        formatter.unitStyle = .full
        
        for post in posts {
            
            // MARK: Gets the driving distance but uses a closure.
            
            
            //                let request = MKDirectionsRequest()
            //                let source = MKPlacemark(coordinate: userLoc!.coordinate)
            //                let p = CLLocationCoordinate2DMake(post.lat, post.long)
            //                let destination = MKPlacemark(coordinate: p)
            //                request.source = MKMapItem(placemark: source)
            //                request.destination = MKMapItem(placemark: destination)
            //                request.transportType = .automobile
            //
            //                let directions = MKDirections(request: request)
            
            
            // Sorting distance needs to be corrected.
            let postLoc = CLLocation(latitude: post.lat, longitude: post.long)
            let distance = userLoc?.distance(from: postLoc)
            let d = formatter.string(fromDistance: distance!)
//            let p = formatter.distance(from: d)
            post.distance = d
        }
        sortedArray = posts.sorted(by: {$0.distance < $1.distance})
        posts = sortedArray
        tableView.reloadData()
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
}

// Search Controller extension
extension SearchTableViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        if currentUser.artist == "true" {
            switch selectedScope {
            case 0 :
                sortPosts()
            case 1 :
                let sortedArray = posts.sorted(by: {$0.genre < $1.genre})
                posts = sortedArray
                tableView.reloadData()
            default:
                print("selected artist Scope out of range.")
            }
            
            
        } else if currentUser.venue == "true"{
            switch selectedScope {
            case 0 :
                print("Venue 0")
            case 1 :
                print("Venue 1")
            default:
                print("selected venue Scope out of range.")
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

// Location Manager extension
extension SearchTableViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLoc = locations[0]
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationServices()
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}
