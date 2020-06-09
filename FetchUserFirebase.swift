//
//  FetchUserFirebase.swift
//  Chat
//
//  Created by Jean Paull on 06/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class FetchUserFirebase: NSObject {
    
    static let shared = FetchUserFirebase()
    
    func getUsers(completion:@escaping(_ listOfUser:[[String:Any]])->Void) {
        
        var list = [[String:Any]]()
        
        let instance = GetInstanceFirebase.shared.firestore()
        
        instance.collection("users").order(by: "name").addSnapshotListener(includeMetadataChanges: false) { (dataSnapshot, error) in
            
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            }else{
                
                guard let snapshot = dataSnapshot else {return}
                
                for data in snapshot.documents {
                    
                    //somente user diferentes do user current
                    if data.documentID != GetInstanceFirebase.shared.currentUserId(){
                        list.append(data.data())
                    }
                }
                
                completion(list)
                
            }
            
        }
        
    }
    
}
