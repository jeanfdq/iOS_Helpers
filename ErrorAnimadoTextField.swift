//
//  ErrorAnimadoTextField.swift
//  App Viagens
//
//  Created by Jean Paull on 30/03/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class ErrorAnimadoTextField: NSObject {
    
    func animar(_ textField:UITextField){

        
        let chacoalhar = CABasicAnimation(keyPath: "position")
        
        chacoalhar.duration = 0.1
        chacoalhar.repeatCount = 2
        chacoalhar.autoreverses = true
        
        let posTo = CGPoint(x: textField.center.x + 5, y: textField.center.y)
        let posBack = CGPoint(x: textField.center.x - 5, y: textField.center.y)
        
        chacoalhar.fromValue = posTo
        chacoalhar.toValue = posBack
        
        textField.layer.add(chacoalhar, forKey: nil)
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
        
    }

}
