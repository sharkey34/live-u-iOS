//
//  PostDetailsViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/12/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import Firebase
import MapKit
import CoreLocation

class PostDetailsViewController: UIViewController {
    let locationManager = CLLocationManager()
    var geocoder = CLGeocoder()
    
    @IBOutlet var labelCollection: [UILabel]!
    @IBOutlet weak var postImageView: UIImageView!
    @IBOutlet weak var mapView: MKMapView!
    var ref: DatabaseReference!
    var localPost: Posts!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func applyButtonSelected(_ sender: UIButton) {
        // TODO: Save Correctly
        if let currentUser = UserDefaults.standard.currentUser(forKey: "currentUser") {
            ref.child("posts").child(localPost.uid).child("applied").updateChildValues([currentUser.uid: currentUser.fullName])
            ref.child("users").child(currentUser.uid).child("applied").updateChildValues([localPost.uid: localPost.title])
            
            sender.isEnabled = false
            sender.backgroundColor = UIColor.black
            sender.setTitle("Applied", for: .normal)
        }
    }
    
    func setup(){
        checkLocationServices()
        centerViewOnVenueLocation()
        mapView.layer.cornerRadius = 15
        ref = Database.database().reference()
        postImageView.image = #imageLiteral(resourceName: "VenueProfile")
        labelCollection[0].text = localPost.title
        labelCollection[1].text = localPost.date
        labelCollection[2].text = localPost.genre
        labelCollection[3].text = localPost.budget
        labelCollection[4].text = localPost.location
    }
    
    
    //Location functions
    func locationManagerSetup(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManagerSetup()
        } else {
            //Display alert telling user to turn on location services
        }
    }
    
    
    func centerViewOnVenueLocation(){
        // Get Location coordinates from venue.
        geocoder.geocodeAddressString("46 N Orange Ave, Orlando, FL 32801") { (placemarks, error) in
            if let _ = error {
                
                // Alert the user
                return
            }
            if let placemarks = placemarks?.first {
                
                let lat = placemarks.location?.coordinate.latitude
                let long = placemarks.location?.coordinate.longitude
                // Alert the user
                let rgn = MKCoordinateRegionMakeWithDistance(
                    CLLocationCoordinate2DMake(lat!, long!), 350, 350)
                let venue = MKPointAnnotation()
                venue.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                self.mapView.addAnnotation(venue)
                self.mapView.setRegion(rgn, animated: true)
            }
        }
        
    }
}
