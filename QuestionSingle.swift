//
//  QuestionSingle.swift
//  InstagramClone
//
//  Created by Jean Paull on 22/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class QuestionSingle: NSObject {
    
    func exec(_ view:UIViewController, _ title:String, _ message:String, completion:@escaping(_ response:Bool)->Void){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "confirme", style: .default) { (action) in
            completion(true)
        }
        let btnCancel = UIAlertAction(title: "cancel", style: .cancel) { (action) in
            completion(false)
        }
        btnCancel.setValue(UIColor.red, forKey: "titleTextColor")
        
        alert.addAction(btnOK)
        alert.addAction(btnCancel)
        
        view.present(alert, animated: true, completion: nil)
        
    }

}
