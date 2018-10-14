//
//  CollapsableViewModel.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import Foundation

class CollapsableViewModel {
    let owner: Owner?
    var isCollapsed: Bool
    var isVehicle:Bool
    var vehicle:Vehicle?
    var userID:Int
    var childrens:[CollapsableViewModel]?
    
    init(owner:Owner, childrens: [CollapsableViewModel] = []) {
        self.owner = owner
        self.isCollapsed = true
        self.isVehicle = false
        self.childrens = childrens
        self.vehicle = nil
        self.userID = -1
    }
    
    init(vehicle:Vehicle, userID:Int) {
        self.owner = nil
        self.isCollapsed = true
        self.isVehicle = true
        self.childrens = [CollapsableViewModel]()
        self.vehicle = vehicle
        self.userID = userID
    }
}
