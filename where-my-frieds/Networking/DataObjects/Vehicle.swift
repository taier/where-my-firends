//
//  Vehicle.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

let Vehicle_ID_Undefined = -1

class Vehicle: NSObject, Codable {
    var vehicleid:Int = Vehicle_ID_Undefined
    var make:String = ""
    var model:String = ""
    var year:String = ""
    var color:String = ""
    var vin:String = ""
    var foto:String = ""
}
