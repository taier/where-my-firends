//
//  VehicleTableViewCell.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import Kingfisher

class VehicleTableViewCell: ListTableViewCellBase {

    // MARK: - Outlets
    @IBOutlet weak var iboImgViewVehicle: UIImageView!
    @IBOutlet weak var iboLabelVehicleInfo: UILabel!
    
    @IBOutlet weak var iboViewColor: UIView!
    
    static let reusableIdentifier = "VehicleTableViewCell"
    
    // MARK: - Actions
    func setCell(vehicle:Vehicle) {
        super.setCell()
        
        self.iboLabelVehicleInfo.text = "\(vehicle.make) \(vehicle.model)"
        self.iboViewColor.backgroundColor = UIColor.init(hexFromString:vehicle.color)
        
        let imagePlaceholder = UIImage(named: "img_car_plaseholder")
        self.setImageAsync(urlString: vehicle.foto, imgView: self.iboImgViewVehicle, placeholder: imagePlaceholder)
    }
    
    override func clearViews() {
        self.iboImgViewVehicle.image = nil
        self.iboLabelVehicleInfo.text = ""
        self.iboViewColor.backgroundColor = UIColor.clear
    }
}
