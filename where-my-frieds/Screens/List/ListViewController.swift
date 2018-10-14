//
//  ListViewController.swift
//  where-my-frieds
//
//  Created by Den on 10/5/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class ListViewController: ViewControllerBase {

    // MARK: - Outlets
    @IBOutlet weak var iboTableView: UITableView!
    
    // MARK: - Variables
    static let SEQUE_SHOW_LIST:String = "show_list"
    var displayedRows: [CollapsableViewModel] = []
    var selectedUserID:Int = -1
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableViews()
        self.updateUIForNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.title = "friends_online".localized()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == MapViewController.SEQUE_SHOW_MAP {
            if let destVC = segue.destination as? MapViewController {
                destVC.userId = selectedUserID
            }
        }
    }
    
    override func updateUIForNewData() {
        super.updateUIForNewData()
        
        self.setupData()
    }
}
