//
//  DataManagerPersistant.swift
//  where-my-frieds
//
//  Created by Den on 10/14/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import SQLite

extension DataManager {
    
    func setupDB() {
        let path = NSSearchPathForDirectoriesInDomains(
            .documentDirectory, .userDomainMask, true
            ).first!
        
        do {
            self.dbConnection = try Connection("\(path)/db.sqlite3")
            try self.dbConnection!.run(vehiclesLocation.create(ifNotExists: true) { t in
                t.column(vehicle_id, primaryKey: true)
                t.column(lat)
                t.column(lon)
                t.column(expiration)
            })
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addOrUpdateVehiclePosition(vehicleLocation:VehicleLocation) {
        do {
            let expirationInterval = TimeInterval(SchedulerManager.refreshVehicleLocationTimeInSeconds) // Experation 30 seconds
            let timestamp = Date().addingTimeInterval(expirationInterval).timeIntervalSince1970
            
            let vehicle = vehiclesLocation.filter(vehicle_id == Int64(vehicleLocation.vehicleid))
            
            // try to update
            if try self.dbConnection!.run(vehicle.update(lat <- vehicleLocation.lat,
                                                         lon <- vehicleLocation.lon,
                                                         expiration <- Int64(timestamp))) > 0 { // check the rowcount
                
                print("updated vehicle")
                
            } else { // update returned 0 because there was no match
                
                // insert
                try self.dbConnection!.run(vehiclesLocation.insert(vehicle_id <- Int64(vehicleLocation.vehicleid),
                                                                   lat <- vehicleLocation.lat,
                                                                   lon <- vehicleLocation.lon,
                                                                   expiration <- Int64(timestamp)))
                
                print("insert vehicle")
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func getVehicleLocationsForUser(userID:Int) -> [VehicleLocation] {
        
        var vehicleLocations:[VehicleLocation] = [VehicleLocation]()
        guard let dataObject = getDataObjectForUser(userID: userID) else {
            return vehicleLocations
        }
        
        for vehicle in dataObject.vehicles! {
            let vehicleQuery = vehiclesLocation.filter(vehicle_id == Int64(vehicle.vehicleid))
            
            do {
                for vehicleFromDB in try self.dbConnection!.prepare(vehicleQuery) {
                    
                    let vehicleObject = VehicleLocation()
                    vehicleObject.lat = try vehicleFromDB.get(lat)
                    vehicleObject.lon = try vehicleFromDB.get(lon)
                    vehicleObject.vehicleid = Int(try vehicleFromDB.get(vehicle_id))
                    vehicleObject.expiration = Int64(try vehicleFromDB.get(expiration))
                    
                    vehicleLocations.append(vehicleObject)
                }
                
            } catch {
                print(error.localizedDescription)
            }
        }
        
        return vehicleLocations
    }
}

