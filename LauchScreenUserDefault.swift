//
//  LauchScreenUserDefault.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class LauchScreenUserDefault: NSObject {

    let key = "LauchScreen"
    let defaults = UserDefaults.standard
    
    func saveFlag(_ flag:Bool){
        
        defaults.set(flag, forKey: key)
        
    }
    
    func getFlag() -> Bool {
        return defaults.bool(forKey: key)
    }
    
}
