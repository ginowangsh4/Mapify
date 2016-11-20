//
//  DataController.swift
//  Wildhacks2016
//
//  Created by Wyatt Mufson on 11/19/16.
//  Copyright © 2016 WMG. All rights reserved.
//

import UIKit
import MapKit

class DataController: NSObject {

    func getJSON(location:CLLocationCoordinate2D, completionHandler: @escaping (Data) -> ()) {
        let lat = location.latitude
        let lon = location.longitude
        
        let site = "http://52.33.227.176:8000/locations?lat=\(lat)&lon=\(lon)"
        let url = URL(string: site)
        var request = URLRequest(url: url!)
        
        request.httpMethod = "GET"
        let session = URLSession.shared
        
        session.dataTask(with: request) {data, response, err in
            
            if (err != nil) {
                print("\(err)\n\n")
                completionHandler(Data())
            } else {
                completionHandler(data!)
            }
            
            }.resume()
    }
    
    
}
