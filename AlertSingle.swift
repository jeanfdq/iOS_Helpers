//
//  AlertSingle.swift
//  Chat
//
//  Created by Jean Paull on 05/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class AlertSingle: NSObject {
    
    static let shared = AlertSingle()
    
    func showAlert(_ view:UIViewController, _ title:String, _ message:String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(btnOK)
        view.present(alert, animated: true, completion: nil)
        
    }
    
}
