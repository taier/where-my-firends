//
//  DataManager.swift
//  where-my-frieds
//
//  Created by Den on 10/10/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import SQLite

class DataManager: NSObject, DataManagerProtocol {
    
    static let shared = DataManager()
    private var dataObjects:[DataObject] = [DataObject]()
    var dbConnection:Connection?
    
    let vehiclesLocation = Table("vehicle_locations")
    let vehicle_id = Expression<Int64>("vehicle_id")
    let lat = Expression<Double>("lat")
    let lon = Expression<Double>("lon")
    let expiration = Expression<Int64>("expiration")
    
    override init() {
        super.init()
        self.setupDB()
    }
    
    //MARK: - Protocol Functions
    func getDataObjects() -> [DataObject] {
        return self.dataObjects
    }
    
    func setDataObjects(dataObjects:[DataObject]) {
        self.dataObjects = dataObjects
    }
    
    func getUserNameForID(userID:Int) -> String {
        
        var returnValue = ""
        if let owner = getOwnerWithID(userID: userID) {
            returnValue = "\(owner.name) \(owner.surname)"
        }
        
        return returnValue
    }
    
    func userExistWithID(userID:Int) -> Bool {
        return getOwnerWithID(userID: userID) != nil
    }
    
    func getDataObjectForUser(userID:Int) -> DataObject? {
        var dataObject:DataObject? = nil
        for data in self.dataObjects {
            if(data.userid == userID) {
                dataObject = data
                break
            }
        }
        
        return dataObject
    }
    
    func getOwnerWithID(userID:Int) -> Owner? {
        var owner:Owner? = nil
        for dataObject in self.dataObjects {
            if(dataObject.userid == userID) {
                owner = dataObject.owner!
                break
            }
        }
        
        return owner
    }
    
    func getVehicleForID(vehicleID:Int) -> Vehicle? {
        var vehicle:Vehicle? = nil
        for dataObject in self.dataObjects {
            for ownerVehice in dataObject.vehicles! {
                if(ownerVehice.vehicleid == vehicleID) {
                    vehicle = ownerVehice
                    break
                }
            }
        }
        
        return vehicle
    }
}
