//
//  MapViewControllerDelegates.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import GoogleMaps

extension MapViewController : CLLocationManagerDelegate, GMSMapViewDelegate, CustomMapMarkerDelegate {
   
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == CLAuthorizationStatus.authorizedWhenInUse {
            (self.view as! GMSMapView).isMyLocationEnabled = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // do whatever you want here with the location
        (self.view as! GMSMapView).camera = GMSCameraPosition.camera(withTarget: locations.first!.coordinate, zoom: 13.0)
        (self.view as! GMSMapView).settings.myLocationButton = true
        self.lastUserLocation = locations.first
    }
    
    //Market Tap Function
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        
        if(self.currentMarker != nil) {
            self.currentMarker?.removeFromSuperview()
        }
        
        guard let customMarker = CustomMapMarker.loadNiB() else {
            return false
        }
        
        guard let vehicle = DataManager.shared.getVehicleForID(vehicleID: (marker as! CustomGMSMarker).vehicleID!) else {
            return false
        }
        
        customMarker.delegate = self
        // Configure UI properties of info window
        customMarker.alpha = 0.9
        customMarker.layer.cornerRadius = 12
        customMarker.layer.borderWidth = 2
        customMarker.layer.borderColor = UIColor.init(hexFromString: "19E698").cgColor
        
        customMarker.setupMarker(position: marker.position, vehicleImgURL: URL(string:vehicle.foto)!, vehicleName:vehicle.make , color: UIColor.init(hexFromString: vehicle.color))

        customMarker.center = mapView.projection.point(for: marker.position)
        customMarker.center.y = customMarker.center.y - 130
        self.currentMarker = customMarker
        self.view.addSubview(self.currentMarker!)
        return true
        
    }
    
    func didTapNavigateTo(position: CLLocationCoordinate2D) {
        self.requestDataForPath(positionTo: position)
        
        if(self.currentMarker != nil) {
            self.currentMarker?.removeFromSuperview()
        }
    }
    
    func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
        if(self.currentMarker != nil) {
            self.currentMarker?.removeFromSuperview()
        }
    }
}
