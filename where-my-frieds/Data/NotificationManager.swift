//
//  NotificationManager.swift
//  where-my-frieds
//
//  Created by Den on 10/10/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class NotificationManager: NSObject {
    static func sendDidUpdateAllData() {
         NotificationCenter.default.post(name:Notification.Name.didReceiveAllData, object: nil)
    }
    
    static func sendDidVehicleData() {
        NotificationCenter.default.post(name:Notification.Name.didReceiveVehicleData, object: nil)
    }
}

extension Notification.Name {
    static let didReceiveAllData = Notification.Name("didReceiveAllData")
    static let didReceiveVehicleData = Notification.Name("didReceiveVehicleData")
}
