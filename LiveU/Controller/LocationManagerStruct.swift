
//
//  LocationManagerStruct.swift
//  LiveU
//
//  Created by Eric Sharkey on 9/15/18.
//  Copyright © 2018 Eric Sharkey. All rights reserved.
//

import Foundation
import CoreLocation

struct LoMan {
    
    static func checkLocationPermissions(locationManager: CLLocationManager){
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
}
