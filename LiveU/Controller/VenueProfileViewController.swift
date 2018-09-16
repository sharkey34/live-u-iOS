//
//  VenueProfileViewController.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/7/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit
import CoreLocation

class VenueProfileViewController: UIViewController {
    
    var geocoder = CLGeocoder()
    private var ref: DatabaseReference!
    var currentUser:User!
    let locationManager = CLLocationManager()

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var descriptionTextField: UITextView!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    func setup(){
        checkLocationServices()
        centerViewOnVenueLocation()
        currentUser = UserDefaults.standard.currentUser(forKey: "currentUser")
        if let user = currentUser{
            profileImageView.image = #imageLiteral(resourceName: "VenueProfile")
            venueNameLabel.text = user.fullName
            descriptionTextField.text = currentUser.about
        }
        ref = Database.database().reference()
        backgroundView.layer.cornerRadius = 15
        mapView.layer.cornerRadius = 15
    }
    // Location Manager Functions
    func checkLocationPermissions(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            // logic here
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
    
        //Location functions
    func locationManagerSetup(){
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled() {
            locationManagerSetup()
            checkLocationPermissions()
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
                venue.title = self.currentUser.fullName
                venue.coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: long!)
                self.mapView.addAnnotation(venue)
                self.mapView.setRegion(rgn, animated: true)
            }
        }
        
    }

}

extension VenueProfileViewController: MKMapViewDelegate {
    
}
