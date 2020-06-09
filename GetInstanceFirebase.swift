//
//  GetInstanceFirebase.swift
//  Chat
//
//  Created by Jean Paull on 02/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

struct GetInstanceFirebase {
    
    static let shared = GetInstanceFirebase()
    
    func storage() -> StorageReference {
        return Storage.storage().reference()
    }
    
    func firestore() -> Firestore {
        return Firestore.firestore()
    }
    
    func auth() -> Auth {
        return Auth.auth()
    }
    
    func currentUserName() -> String {
        return Auth.auth().currentUser?.displayName ?? ""
    }
    func currentUserId() -> String {
        return Auth.auth().currentUser?.uid ?? ""
    }
    
}
