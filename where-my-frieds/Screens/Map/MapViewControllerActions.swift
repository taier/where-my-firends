//
//  MapViewControllerActions.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import GoogleMaps
import Alamofire

extension MapViewController {
    
    func clearMap() {
        (self.view as! GMSMapView).clear()
    }
    
    func addVehicleOnMap(vehicleLocation:VehicleLocation) {
        let marker = CustomGMSMarker()
        marker.vehicleID = vehicleLocation.vehicleid
        marker.position = CLLocationCoordinate2D(latitude:vehicleLocation.lat, longitude:vehicleLocation.lon)
        marker.map = (self.view as! GMSMapView)
    }
    
    
    // MARK: - Data Updates
    func requestDataForPath(positionTo:CLLocationCoordinate2D) {
        
        // Create a request
        let requestHandler: ()-> Void = {
            
            let fromLat = String(stringInterpolationSegment:self.lastUserLocation!.coordinate.latitude)
            let fromLon = String(stringInterpolationSegment:self.lastUserLocation!.coordinate.longitude)
            
            let toLat = String(stringInterpolationSegment:positionTo.latitude)
            let toLon = String(stringInterpolationSegment:positionTo.longitude)
            
            NetworkManager.getGoogleDirections(locationFrom:"\(fromLat),\(fromLon)", locationTo:"\(toLat),\(toLon)", onSucces: { (points) in
                    
                let path = GMSMutablePath(fromEncodedPath: points)
                /* set up poly line */
                let polyline = GMSPolyline.init(path: path)
                polyline.strokeWidth = 5
                polyline.map = (self.view as! GMSMapView)
                
            }, onError: { (error) in
                self.onError(error: error, onRetryHandler: self.lastRequestHandler)
            })
        }
        
        // Remember request for retry
        self.lastRequestHandler = requestHandler
        
        // Trigger request
        requestHandler()
    }
    
    func drawPath (origin: String, destination: String) {

    }
    
    func closeViewController() {
        self.navigationController?.popViewController(animated:true)
    }
}
