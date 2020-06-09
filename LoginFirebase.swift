//
//  LoginFirebase.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import FirebaseAuth

class LoginFirebase: NSObject {
    
    func login(_ email:String, _ password:String, completion:@escaping(_ response:Bool)->Void){
        
        let instance = GetInstancesFirebase().getAuth()
        instance.signIn(withEmail: email, password: password) { (result, err) in
            
            if err == nil {
                completion(true)
            }else{
                completion(false)
            }
            
        }
        
    }

}
