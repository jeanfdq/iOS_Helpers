//
//  SendMessageToFriend.swift
//  Chat
//
//  Created by Jean Paull on 06/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseFirestore

struct SendMessageToFriend {
    
    static let shared = SendMessageToFriend()
    
    func send(_ sendMsg:SendMessage, completion:@escaping(_ response:Bool)->Void) {
        
        let myId = GetInstanceFirebase.shared.currentUserId()
        
        let instanceDB = GetInstanceFirebase.shared.firestore()
        
        let dictionaryMsg:Dictionary<String,Any> = ["idSender":sendMsg.idSender, "nameSender":sendMsg.nameSender, "idDestination" : sendMsg.idDestination, "nameDestination": sendMsg.nameDestination, "msg":sendMsg.message, "imageURL":sendMsg.imageUrl ,"imageWidth":sendMsg.imageWidth ,"imageHeight":sendMsg.imageHeight, "date": FieldValue.serverTimestamp() ]
        
        instanceDB.collection("users").document(myId).collection("messages")
            .addDocument(data: dictionaryMsg) { (error) in
                
                if error == nil {
                    
                    instanceDB.collection("users").document(sendMsg.idDestination).collection("messages")
                        .addDocument(data: dictionaryMsg) { (error) in
                            
                            if error == nil {
                                
                                //Criar ou Atualizar a Ultima Msg
                                instanceDB.collection("users").document(myId).collection("last_messages").document(myId).setData(dictionaryMsg) { (erro) in
                                    
                                    if error == nil {
                                        
                                        instanceDB.collection("users").document(sendMsg.idDestination).collection("last_messages").document(sendMsg.idDestination).setData(dictionaryMsg) { (error) in
                                            
                                            if error == nil {
                                                completion(true)
                                            }else{
                                                completion(false)
                                            }
                                            
                                        }
                                        
                                    }else{
                                        completion(false)
                                    }
                                    
                                }
                                
                                
                            }else{
                                completion(false)
                            }
                            
                    }
                    
                }else{
                    completion(false)
                }
                
        }
        
    }
    
}
