//
//  ListTableViewCellBase.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class ListTableViewCellBase: UITableViewCell {

    // MARK: - Actions
    func setImageAsync(urlString:String, imgView:UIImageView, placeholder:UIImage?) {
        let url:URL = URL(string: urlString)!
        imgView.kf.setImage(with: url, placeholder: placeholder)
    }
    
    func clearViews() {
        
    }
    
    func setCell() {
        self.clearViews()
    }
}
