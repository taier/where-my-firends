//
//  MapViewController.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: ViewControllerBase {
    
    // MARK: - Variables
    static let SEQUE_SHOW_MAP:String = "show_map"
    
    var locationManager = CLLocationManager()
    var lastUserLocation:CLLocation?
    var didFindMyLocation = false
    var currentMarker:CustomMapMarker?
    var userId:Int = -1
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup UI
        self.setupInitialMap()
        self.setupUserLocation()
        
        self.updateUIForVehicleData() 
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.setupUserName()
        
        // Start scheduler for refresh
        SchedulerManager.shared.changeVehicleDataUpdates(start: true, userID:self.userId)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Stop scheduler for refresh
        SchedulerManager.shared.changeVehicleDataUpdates(start: false, userID:self.userId)
    }
    
    override func updateUIForNewData() {
        super.updateUIForNewData()
        
        // User does not exist, exit
        if(!DataManager.shared.userExistWithID(userID: self.userId)) {
            self.closeViewController()
        }
    }
    
    override func updateUIForVehicleData() {
        super.updateUIForVehicleData()
        
        self.clearMap()
        for item in DataManager.shared.getVehicleLocationsForUser(userID: self.userId) {
            self.addVehicleOnMap(vehicleLocation: item)
        }
        
        print("Update map")
    }
}
