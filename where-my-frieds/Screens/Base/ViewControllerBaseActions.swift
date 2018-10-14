//
//  ViewControllerBaseActions.swift
//  where-my-frieds
//
//  Created by Den on 10/7/18.
//  Copyright © 2018 Deniss Kaibagarovs. All rights reserved.
//

import UIKit

extension ViewControllerBase {
    
    func onError(error:String, onRetryHandler: @escaping ()->Void = {}) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler:nil))
        
        alert.addAction(UIAlertAction(title: "Retry", style: .default, handler: { action in
            onRetryHandler()
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
