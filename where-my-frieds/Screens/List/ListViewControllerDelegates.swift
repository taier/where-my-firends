//
//  ListViewControllerDelegates.swift
//  where-my-frieds
//
//  Created by Den on 10/5/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

extension ListViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.displayedRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:UITableViewCell
        let item = self.displayedRows[indexPath.row]
        if(item.isVehicle) {
            cell = tableView.dequeueReusableCell(withIdentifier: VehicleTableViewCell.reusableIdentifier)! as! VehicleTableViewCell
            (cell as! VehicleTableViewCell).setCell(vehicle: item.vehicle!)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FriendTableViewCell.reusableIdentifier)! as! FriendTableViewCell
            (cell as! FriendTableViewCell).setCell(owner: item.owner!, vehiclesCount:item.childrens!.count)
        }
        
        return cell
    }
}


extension ListViewController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        let viewModel:CollapsableViewModel = displayedRows[indexPath.row]
        
        // If Vehicle - show map
        if(viewModel.isVehicle) {
            self.selectedUserID = viewModel.userID
            self.showMapController()
            return
        }
        
        // If Owner has vehicles - show vehicles
        if viewModel.childrens!.count > 0 {
            let range = indexPath.row + 1...indexPath.row + viewModel.childrens!.count
            let indexPaths = range.map{ return IndexPath(row: $0, section: indexPath.section)}
            tableView.beginUpdates()
            if viewModel.isCollapsed {
                displayedRows.insert(contentsOf:viewModel.childrens!, at: indexPath.row+1)
                tableView.insertRows(at: indexPaths, with: .automatic)
            } else {
                displayedRows.removeSubrange(range)
                tableView.deleteRows(at: indexPaths, with: .automatic)
            }
            tableView.endUpdates()
        }
        viewModel.isCollapsed = !viewModel.isCollapsed
    }
}

