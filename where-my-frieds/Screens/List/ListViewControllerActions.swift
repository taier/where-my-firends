//
//  ListViewControllerActions.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

extension ListViewController {
    
    func setupData() {

        self.displayedRows.removeAll()
        
        for dataObject in DataManager.shared.getDataObjects() {
            var childrens:[CollapsableViewModel] = [CollapsableViewModel]()
            
            for vehicle in dataObject.vehicles! {
                childrens.append(CollapsableViewModel(vehicle: vehicle, userID:dataObject.userid))
            }
            
            self.displayedRows.append(CollapsableViewModel(owner: dataObject.owner!, childrens: childrens))
        }
        
        self.iboTableView.reloadData()

    }
    
    func showMapController() {
        self.performSegue(withIdentifier: MapViewController.SEQUE_SHOW_MAP, sender: nil)
    }
}
