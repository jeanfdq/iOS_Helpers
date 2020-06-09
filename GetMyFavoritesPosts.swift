//
//  GetMyFavoritesPosts.swift
//  InstagramClone
//
//  Created by Jean Paull on 25/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class GetMyFavoritesPosts: NSObject {
    
    let instance = GetInstancesFirebase().getFirestore()
    
    func getData(completion:@escaping(_ listFavorites:[String])->Void) {
        
        var listPostsId:[String] = []
        
        
        let myFavoritePosts = instance.collection("users").document(GetInstancesFirebase().getCurrentUserId())
            .collection("MyFavoristePosts")
        myFavoritePosts.getDocuments { (snapshot, err) in
            
            guard let snapshot = snapshot else {return}
            
            for result in snapshot.documents {
                listPostsId.append(result.data()["post"] as! String)
            }
            completion(listPostsId)
            
        }
        
    }

}
