//
//  StartViewControllerActions.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import Foundation

extension StartViewController {
    
    // MARK: - UI Updates
    func updateFriendsOnline(friendsOnlineCount:Int) {
        self.iboLabelFriendsOnline.text = "\(friendsOnlineCount) " + "friends_online".localized()
    }
    
    func showListController() {
        self.performSegue(withIdentifier: ListViewController.SEQUE_SHOW_LIST, sender: nil)
    }
    
}
