//
//  GetUser.swift
//  InstagramClone
//
//  Created by Jean Paull on 23/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GetUser: NSObject {
    
    func getData(completion:@escaping(_ user:User)->Void) {
        
        let instance = GetInstancesFirebase().getFirestore()
        
        let userFirestore = instance.collection("users")
            .document(GetInstancesFirebase().getCurrentUserId())
        userFirestore.getDocument { (snapshot, err) in
            
            guard let user = snapshot?.data() else {return}
            
            guard let id = user["id"] as? String else {return}
            guard let name = user["name"] as? String else {return}
            guard let email = user["email"] as? String else {return}
            guard let phone = user["phone"] as? String else {return}
            guard let url = user["urlImg"] as? String else {return}
            
            completion(User(id, url, name, email, phone))
            
        }
        
    }

}
