//
//  Owner.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

let Owner_ID_Undefined = -1

class Owner: NSObject, Codable {
    var ownerid:Int? = Owner_ID_Undefined
    var name:String = ""
    var surname:String = ""
    var foto:String = ""
}
