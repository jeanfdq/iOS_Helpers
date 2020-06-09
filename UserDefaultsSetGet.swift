//
//  UserDefaultsSetGet.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class UserDefaultsSetGet: NSObject {

     let preference = UserDefaults.standard
    
    func salvaUserDefault(value:String){
        
        preference.set(value, forKey: "chaveUserDefault")
        
    }
    
    func recuperaUserDefault() -> String {
        
        let value =  preference.object(forKey: "chaveUserDefault") as? String
        
        guard let value2 = value else { return ""}
        return value2
    }
}
