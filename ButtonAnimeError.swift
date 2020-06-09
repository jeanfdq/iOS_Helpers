//
//  ButtonAnimeError.swift
//  Cars
//
//  Created by Jean Paull on 01/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class ButtonAnimeError: NSObject {
    
    
    func anime(_ button:UIButton) {
        
        let chacoalhar = CABasicAnimation(keyPath: "position")
        
        chacoalhar.duration = 0.1
        chacoalhar.repeatCount = 2
        chacoalhar.autoreverses = true
        
        chacoalhar.fromValue = CGPoint(x: button.center.x + 5, y: button.center.y)
        chacoalhar.toValue   = CGPoint(x: button.center.x - 5, y: button.center.y)
        
        button.layer.add(chacoalhar, forKey: nil)
        
    }

}
