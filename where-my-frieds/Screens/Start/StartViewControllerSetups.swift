//
//  StartViewControllerSetups.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

extension StartViewController {

    func setupVisualAdjustments() {
        setupButton(button:self.iboButtonList);
        self.iboViewContainerList.roundCorners()
    }
    
    func setupData() {
        self.updateFriendsOnline(friendsOnlineCount: DataManager.shared.getDataObjects().count)
    }
    
    func setupButton(button:UIButton)  {
        button.roundCorners()
        button.layer.borderColor = button.backgroundColor?.cgColor
        button.layer.borderWidth = 1
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOpacity = 0.2
        button.layer.shadowOffset = CGSize.zero
        button.layer.shadowRadius = 3
    }
    
}
