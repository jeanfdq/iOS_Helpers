//
//  CreateUserModelFirebase.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CreateUserModelFirebase: NSObject {

    func saveUser(_ user:User, completion:@escaping(_ response:Bool)->Void){
        
        if let urlImg = user.urlImgUser {
            
            let instance = GetInstancesFirebase().getFirestore()
            let users = instance.collection("users")
                .document(user.idUser)
            users.setData(["id" : user.idUser, "urlImg":urlImg, "name":user.nameUser, "email":user.emailUser, "phone":user.phoneNumberUser]) { (err) in
                
                if err == nil {
                    completion(true)
                }else{
                    completion(false)
                }
            }
            
        }else{
            completion(false)
        }
        
        
        
        
        
    }
    
}
