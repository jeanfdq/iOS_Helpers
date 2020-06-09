//
//  RemoveFavoritePost.swift
//  InstagramClone
//
//  Created by Jean Paull on 25/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class RemoveFavoritePost: NSObject {

    let instance = GetInstancesFirebase().getFirestore()
    
    func execRemove(_ idPost:String, completion:@escaping(_ response:Bool)->Void){
        
        let post = instance.collection("users").document(GetInstancesFirebase().getCurrentUserId())
        .collection("MyFavoristePosts")
        .document(idPost)
        post.delete { (err) in
            
            if err == nil{
                completion(true)
            }else{
                completion(false)
            }
            
        }
        
    }
    
}
