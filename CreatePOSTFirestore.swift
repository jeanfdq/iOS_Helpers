//
//  CreatePOSTFirestore.swift
//  InstagramClone
//
//  Created by Jean Paull on 25/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

class CreatePOSTFirestore: NSObject {
    
    func execPost(_ post:Post, completion:@escaping(_ response:Bool)->Void){
        
        let instance = GetInstancesFirebase().getFirestore()
        let postUser = instance.collection("Posts").document(post.idPost)
        
        
        let id          = post.idPost
        let idUser      = GetInstancesFirebase().getCurrentUserId()
        let description = post.descriptionPost
        let name        = post.userPost.nameUser
        let imgPerfil   = post.userPost.urlImgUser
        let urlImg      = post.imgPathPost
        
        postUser.setData(["id" : id, "idUser":idUser, "description":description, "name":name, "imgPerfil":imgPerfil!, "img":urlImg, "time":FieldValue.serverTimestamp()]) { (err) in
            
            if err == nil {
                
                let mypost = instance.collection("users").document(GetInstancesFirebase().getCurrentUserId())
                    .collection("MyPosts")
                mypost.addDocument(data: ["post" : id])
                
                completion(true)
            }else{
                completion(false)
            }
            
        }
        
    }

}
