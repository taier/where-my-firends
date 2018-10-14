//
//  DataObject.swift
//  where-my-frieds
//
//  Created by Den on 10/9/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class DataObject: NSObject, Codable {
    @objc dynamic var userid:Int = -1
    @objc dynamic var owner:Owner?
    @objc dynamic var vehicles:Array<Vehicle>?
}
