//
//  DataUserDefault.swift
//  Chat
//
//  Created by Jean Paull on 05/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class DataUserDefault: NSObject {
    
    static let shared = DataUserDefault()
    
    let defaults = UserDefaults.standard
    
    func setValue(_ key:String, value:Any){
        defaults.set(value, forKey: key)
    }
    
    func getValue(_ key:String) -> Any? {
        return defaults.object(forKey: key)
    }
    
}
