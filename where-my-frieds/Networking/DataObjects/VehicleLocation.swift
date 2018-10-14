//
//  VehicleLocation.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class VehicleLocation: NSObject, Codable {
    var vehicleid:Int = Vehicle_ID_Undefined
    var lat:Double = -1
    var lon:Double = -1
    var expiration:Int64? = -1
    
    
    func isExpired() ->Bool {
        return Int64(Date().timeIntervalSince1970) > self.expiration!
    }
}
