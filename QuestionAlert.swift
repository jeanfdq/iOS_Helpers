//
//  QuestionAlert.swift
//  uber_clone
//
//  Created by Jean Paull on 14/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class QuestionAlert: NSObject {
    
    func execQuestion(_ viewController:UIViewController, _ title:String, _ message:String, completion:@escaping(_ response:Bool) -> Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirme = UIAlertAction(title: "confirmar", style: .default) { (actions) in
            completion(true)
        }
        
        let cancel = UIAlertAction(title: "cancelar", style: .cancel) { (action) in
            completion(false)
        }
        cancel.setValue(UIColor.red, forKey: "titleTextColor")
        alert.addAction(confirme)
        alert.addAction(cancel)
        
        viewController.present(alert, animated: true, completion: nil)
        
    }

}
