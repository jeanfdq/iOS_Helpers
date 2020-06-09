//
//  CreateUserFirebase.swift
//  Chat
//
//  Created by Jean Paull on 02/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct CreateUserFirebase {
    
    static let shared = CreateUserFirebase()
    
    func create(_ user:User, completion:@escaping(_ response:Bool)->Void) {
        
        let instanceAuth = GetInstanceFirebase.shared.auth()
        let instanceDB = GetInstanceFirebase.shared.firestore()
        
        instanceAuth.createUser(withEmail: user.email, password: user.password) { (result, error) in
            
            if error != nil {
                print(error!.localizedDescription)
                completion(false)
            }else{
                
                if let userFirebase = result?.user {
                    let changeRequest = userFirebase.createProfileChangeRequest()
                    changeRequest.displayName = user.name.trim()
                    changeRequest.commitChanges { (error) in
                        
                        if error != nil {
                            completion(false)
                        }else{
                            
                            instanceDB.collection("users").document(result!.user.uid).setData(["id":result!.user.uid, "name" : user.name, "email":user.email, "date": FieldValue.serverTimestamp() ]) { (error) in
                                
                                if  error != nil {
                                    completion(false)
                                }else{
                                    completion(true)
                                }
                                
                            }
                            
                        }
                        
                    }
                }
                
            }
            
        }

    }
    
}
