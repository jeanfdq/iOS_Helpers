//
//  CreateMyFavoritePost.swift
//  InstagramClone
//
//  Created by Jean Paull on 25/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class CreateMyFavoritePost: NSObject {
    
    let instance = GetInstancesFirebase().getFirestore()
    
    func execCreate(_ idPost:String, completion:@escaping(_ response:Bool)->Void){
        
        let favoritePost = instance.collection("users")
            .document(GetInstancesFirebase().getCurrentUserId())
            .collection("MyFavoristePosts")
            .document(idPost)
        favoritePost.setData(["post" : idPost]) { (err) in
            if err == nil {
                completion(true)
            }else{
                completion(false)
            }
        }
        
    }
    
}
