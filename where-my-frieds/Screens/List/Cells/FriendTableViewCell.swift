//
//  FriendTableViewCell.swift
//  where-my-frieds
//
//  Created by Den on 10/5/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit
import Kingfisher

class FriendTableViewCell: ListTableViewCellBase {
    
    // MARK: - Outlets
    @IBOutlet weak var iboImgViewAvatar: UIImageView!
    @IBOutlet weak var iboLabelName: UILabel!
    @IBOutlet weak var iboLabelSurname: UILabel!
    @IBOutlet weak var iboLabelVehicleCount: UILabel!
    
    static let reusableIdentifier = "FriendTableViewCell"
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Round corners of avatar
        self.iboImgViewAvatar.roundCorners()
    }
    
    // MARK: - Actions
    func setCell(owner:Owner, vehiclesCount:Int) {
        super.setCell()
        
        self.iboLabelName.text = owner.name
        self.iboLabelSurname.text = owner.surname
        self.iboLabelVehicleCount.text = getVehicleCountString(count:vehiclesCount)
        
        self.setImageAsync(urlString: owner.foto, imgView: self.iboImgViewAvatar, placeholder: nil)
    }
    
    override func clearViews() {
        self.iboImgViewAvatar.image = nil
        self.iboLabelName.text = ""
        self.iboLabelSurname.text = ""
        self.iboLabelVehicleCount.text = ""
    }
    
    func getVehicleCountString(count:Int) -> String {
        return  "\(count) \(count > 1 ? "vehicle_multiple".localized() : "vehicle_one".localized())"
    }
}
