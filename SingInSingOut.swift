//
//  SingInSingOut.swift
//  Chat
//
//  Created by Jean Paull on 05/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseAuth

class SingInSingOut: NSObject {
    
    let instance = GetInstanceFirebase.shared.auth()
    
    static let shared = SingInSingOut()
    
    func singIn(_ email:String, _ password:String, completion:@escaping(_ response:Bool)->Void) {
        
        instance.signIn(withEmail: email, password: password) { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                completion(false)
            }else{
                completion(true)
            }
            
        }
        
    }
    
    func singOut() {
        
        if GetInstanceFirebase.shared.currentUserId() != "" {
            try? instance.signOut()
        }
        
    }
    
}
