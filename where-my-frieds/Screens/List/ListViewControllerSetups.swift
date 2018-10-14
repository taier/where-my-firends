//
//  ListViewControllerSetup.swift
//  where-my-frieds
//
//  Created by Den on 10/5/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

extension ListViewController {
    
    func setupTableViews() {
        self.iboTableView.register(UINib(nibName: "FriendTableViewCell", bundle: nil), forCellReuseIdentifier: FriendTableViewCell.reusableIdentifier)
        
         self.iboTableView.register(UINib(nibName: "VehicleTableViewCell", bundle: nil), forCellReuseIdentifier: VehicleTableViewCell.reusableIdentifier)
        
        self.iboTableView.tableFooterView = UIView()  // hide ghosty cells
    }
}
