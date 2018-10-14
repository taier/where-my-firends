//
//  ViewController.swift
//  where-my-frieds
//
//  Created by Den on 10/4/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class StartViewController: ViewControllerBase {

    // MARK: - Outlets
    @IBOutlet weak var iboLabelFriendsOnline: UILabel!
    @IBOutlet weak var iboViewContainerList: UIView!
    @IBOutlet weak var iboButtonList: UIButton!
    
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupVisualAdjustments()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hideNavigationBar()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar()
    }
    
    // MARK: - Actions
    @IBAction func onListPress(_ sender: Any) {
        self.showListController()
    }
    
    override func updateUIForNewData() {
        super.updateUIForNewData()
        self.setupData()
    }
}


