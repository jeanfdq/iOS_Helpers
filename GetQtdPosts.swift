//
//  GetQtdPosts.swift
//  InstagramClone
//
//  Created by Jean Paull on 25/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

class GetQtdPosts: NSObject {

    func execGet(completion:@escaping(_ qtd:Int)->Void){
        
        let instanceDB = GetInstancesFirebase().getFirestore()
        let posts = instanceDB.collection("users")
            .document(GetInstancesFirebase().getCurrentUserId())
        .collection("MyPosts")
        posts.getDocuments { (snapshot, err) in
            
            guard let snapshot = snapshot else {return}
            
            completion(snapshot.documents.count)
            
        }
        
    }
    
}
