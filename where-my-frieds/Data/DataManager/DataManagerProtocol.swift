//
//  DataManagerProtocol.swift
//  where-my-frieds
//
//  Created by Den on 10/14/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

protocol DataManagerProtocol {
    
    // Checks
    func userExistWithID(userID:Int) -> Bool
    
    // Sets
    func setDataObjects(dataObjects:[DataObject])
    
    // Gets
    func getDataObjectForUser(userID:Int) -> DataObject?
    func getOwnerWithID(userID:Int) -> Owner?
    func getVehicleForID(vehicleID:Int) -> Vehicle?
    func getUserNameForID(userID:Int) -> String
    func getDataObjects() -> [DataObject]
    
    // Persistance
    
    // Sets
    func addOrUpdateVehiclePosition(vehicleLocation:VehicleLocation)
    
    // Gets
    func getVehicleLocationsForUser(userID:Int) -> [VehicleLocation]
}
