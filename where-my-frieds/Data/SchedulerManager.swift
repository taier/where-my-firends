//
//  SchedulerManager.swift
//  where-my-frieds
//
//  Created by Den on 10/10/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class SchedulerManager: NSObject {
    
    static let shared = SchedulerManager()
    static let refreshAllDataTimeInSeconds = 3600.0 // 1 hour
    static let refreshVehicleLocationTimeInSeconds = 30.0 // 30 seconds
    private var runningAllDataUpdates:Bool = false
    private var runningVehicleLocationUpdates:Bool = false
    private var userID:Int = 0
    
    func startAllDataUpdates() {
        if (runningAllDataUpdates) {
            return
        }
        
        runningAllDataUpdates = true
        triggerAndScheduleRefreshAllData()
    }
    
    func changeVehicleDataUpdates(start:Bool, userID:Int) {
        
        if(start && runningVehicleLocationUpdates) { // Already running
            return
        } else if (start && !runningVehicleLocationUpdates) { // Begin running
            runningVehicleLocationUpdates = true
            self.userID = userID
            triggerAndScheduleRefreshVehicleLocation()
        } else { // Turn off
            runningVehicleLocationUpdates = false
        }
    }
    
    private func triggerAndScheduleRefreshAllData() {
        
        if(!runningAllDataUpdates) { // No need to update
            return
        }
        
        self.requestAllData()
        DispatchQueue.main.asyncAfter(deadline: .now() + SchedulerManager.refreshAllDataTimeInSeconds) {
            self.triggerAndScheduleRefreshAllData()
        }
    }
    
    private func triggerAndScheduleRefreshVehicleLocation() {
        if(!runningVehicleLocationUpdates) { // No need to update
            return
        }
        
        var expired = true
        for vehicleLocation in DataManager.shared.getVehicleLocationsForUser(userID: self.userID) {
            if(!vehicleLocation.isExpired()) {
                expired = false
            }
        }
        
        if (expired) {
            self.requestVehicleLocationData()
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + SchedulerManager.refreshVehicleLocationTimeInSeconds) {
            self.triggerAndScheduleRefreshVehicleLocation()
        }
    }
    
    private func requestAllData() {
        NetworkManager.getDataAll(onSucces: { (dataItems) in
            DataManager.shared.setDataObjects(dataObjects: dataItems)
            NotificationManager.sendDidUpdateAllData()
        }, onError: { (error) in
            self.requestAllData() // Silently try again
        })
    }
    
    private func requestVehicleLocationData() {
        NetworkManager.getDataSingle(userID:self.userID, onSucces: { (dataItems) in
            for data in dataItems {
                DataManager.shared.addOrUpdateVehiclePosition(vehicleLocation: data)
            }
            NotificationManager.sendDidVehicleData()
        }, onError: { (error) in
            self.requestVehicleLocationData() // Silently try again
        })
    }
}
