//
//  AuthenticationTouchID.swift
//  Cars
//
//  Created by Jean Paull on 03/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationTouchID: NSObject {

    var error:NSError?
    
    func userAutorize(completion:@escaping(_ autenticado:Bool) -> Void){
        
        let context = LAContext()
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error){
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Necessária a autenticação") { (resposta, error) in
                
                if error == nil {
                    
                    completion(resposta)
                    
                }
                
            }
            
        }
        
    }
}
