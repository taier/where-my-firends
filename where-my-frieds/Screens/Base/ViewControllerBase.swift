//
//  ViewControllerBase.swift
//  where-my-frieds
//
//  Created by Den on 10/5/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

class ViewControllerBase: UIViewController {

    // MARK: - Variables
    var lastRequestHandler: ()-> Void = {}
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addGradientBackground()
        self.updateUIForNewData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveAllData(_:)), name: .didReceiveAllData, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(onDidReceiveVehicleData(_:)), name: .didReceiveVehicleData, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: .didReceiveAllData, object: nil)
        NotificationCenter.default.removeObserver(self, name: .didReceiveVehicleData, object: nil)
    }
    
    // MARK: - Actions
    func hideNavigationBar(){
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func showNavigationBar() {
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    func updateUIForNewData() {
        
    }
    
    func updateUIForVehicleData() {
        
    }
    
    // MARK: - Notifications
    @objc func onDidReceiveAllData(_ notification:Notification) {
        self.updateUIForNewData()
    }
    
    @objc func onDidReceiveVehicleData(_ notification:Notification) {
        self.updateUIForVehicleData()
    }
}
