//
//  GetInstancesFirebase.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//


import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore

class GetInstancesFirebase: NSObject {

    func getAuth() -> Auth {
        
        return Auth.auth()
        
    }
    
    func getCurrentUserId() -> String {
        
        return self.getAuth().currentUser?.uid ?? ""
        
    }
    
    func getStorage() -> StorageReference {
        
        return Storage.storage().reference()
        
    }
    
    func getFirestore() -> Firestore {
        
        return Firestore.firestore()
    }
    
}
