//
//  MapViewController.swift
//  Wildhacks2016
//
//  Created by Wyatt Mufson on 11/19/16.
//  Copyright © 2016 WMG. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController, MKMapViewDelegate {
    
    @IBOutlet weak var mapView: MKMapView!

    var dataArray = [String:AnyObject]()
    
    let locationController = LocationController.sharedInstance
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.showsBuildings = true
        self.navigationController?.isNavigationBarHidden = false
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Map"
        self.mapView.delegate = self
        self.mapView.showsUserLocation = true
        self.mapView.showsBuildings = true
        print(self.mapView.isUserLocationVisible)
        let currentLocation = locationController.userLocation
        
        if currentLocation != nil {
            loadData((currentLocation?.coordinate)!)
        }
        
        mapView.showAnnotations(mapView.annotations, animated: true)

    }

    let regionRadius: CLLocationDistance = 1000
    
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        print("Map Finished Loading")
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        print("Couldn't find user due to: \(error)\n")
    }
    
    func mapViewDidStopLocatingUser(_ mapView: MKMapView) {
        print("Map view stopped locating user\n")
    }
    
    func mapView(_ mapView: MKMapView, didChange mode: MKUserTrackingMode, animated: Bool) {
        print("Map view changed tracking mode\n")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        print("Mapview update location\n")
        let userLoc = userLocation.coordinate
        mapView.centerCoordinate = userLoc
        centerMapOnLocation(location: userLocation.location!)
        //let currentPin = MKPointAnnotation()
        //currentPin.coordinate = userLoc
        //mapView.addAnnotation(currentPin)
        locationController.userLocation = userLocation.location
        loadData(userLoc)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let mav = MKPinAnnotationView()

        mav.pinTintColor = UIColor().colorFromHex(hexValue: "4e2a84", alpha: 1)
        
        mav.canShowCallout = true
        return mav
    }
    
    func addLocationToMap(dict:[String:AnyObject]){
        var lat : Double = 0
        var lon : Double = 0
        
        if let location = dict["location"] {
            if let nlat = location["lat"] as? String {
                lat = Double(nlat)!
            } else {
                print("Failed to find lat\n")
            }
            if let nlon = location["lon"] as? String {
                lon = Double(nlon)!
            } else {
                print("Failed to find lon\n")
            }
        } else {
            print("Failed to find location\n")
        }
        
        let time = dict["end_time"] as! String
        let name = dict["name"] as! String
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lon)
        annotation.title = name
        mapView.addAnnotation(annotation)
        
        print("Pin dropped at (\(lon), \(lat)) for time \(time).\n")
    }
    

    
    func updateWithData(){
        if let facebook = dataArray["Eventbrite"] as? [[String:AnyObject]] {
            for event in facebook {
                addLocationToMap(dict: event)
            }
            fitMapToAnnotations(annotations: self.mapView.annotations)
        } else {
            print("Failed to find Eventbrite\n")
        }
    }
    
    func loadData(_ loc:CLLocationCoordinate2D){
        let dc = DataController()
        
        dc.getJSON(location: loc){data in
            do {
                
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("serialized\n")
                
                if let jsonArray = json as? [String: AnyObject] {
                    if let fields = jsonArray["Locations"] as? [String : AnyObject] {
                        self.dataArray = fields
                        self.updateWithData()
                    } else {
                        print("Failed to find Locations\n")
                    }
                    
                } else {
                    print("Failed to convert: \n\(data)\n")
                }
                
                
            } catch {
                print("error serializing JSON: \n\(error)\n")
            }
        }
    }
    
    func fitMapToAnnotations(annotations:[MKAnnotation]){
        DispatchQueue.main.async {
            let mapEdgePadding = UIEdgeInsets(top: 50, left: 20, bottom: 20, right: 20)
            var zoomRect:MKMapRect = MKMapRectNull
            
            let count = annotations.count
            
            for index in 0..<count {
                if index < annotations.count {
                    let annotation = annotations[index]
                    let point = MKMapPointForCoordinate(annotation.coordinate)
                    let rect = MKMapRectMake(point.x, point.y, 0.1, 0.1)
                    
                    zoomRect = MKMapRectUnion(zoomRect, rect)
                }
            }
            
            if self.mapView.annotations.count == 0 {
                return
            }
            
            self.mapView.setVisibleMapRect(zoomRect, edgePadding: mapEdgePadding, animated: true)
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
