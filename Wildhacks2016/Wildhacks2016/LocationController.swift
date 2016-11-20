//
//  LocationController.swift
//  Wildhacks2016
//
//  Created by Wyatt Mufson on 11/19/16.
//  Copyright © 2016 WMG. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class LocationController: NSObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    
    static let sharedInstance = LocationController()

    var userLocation : CLLocation?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.requestLocation()
        locationManager.startUpdatingLocation()
        locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation

        locationManager.requestWhenInUseAuthorization()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Location manager failed with error: \(error)\n")
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations.last
    }
    
    func locationManager(_ manager: CLLocationManager, monitoringDidFailFor region: CLRegion?, withError error: Error) {
        print("\(error)\n")
    }
}

