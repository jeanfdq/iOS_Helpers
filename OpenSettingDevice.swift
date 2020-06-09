//
//  OpenSettingDevice.swift
//  uber_clone
//
//  Created by Jean Paull on 14/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class OpenSettingDevice: NSObject {

    func exec(){
        
        let urlSettings = UIApplication.openSettingsURLString
        
        if let url = URL(string: urlSettings) {
            
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
            
        }
        
    }
    
}
