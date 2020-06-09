//
//  CreateImageFirebase.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import FirebaseStorage

class CreateImageFirebase: NSObject {

    func saveImg(_ image:UIImage, completion:@escaping(_ url:String)->Void) {
        
        guard let imgData = image.jpegData(compressionQuality: 0.3) else {return}
        let now = Date()
        let nameImg = "image_" + now.getDateToString("dd_MM_yyyy_mm_ss") + ".jpeg"
        
        let instance = GetInstancesFirebase().getStorage()
        let imgStorage = instance.child("imgPerfil").child(nameImg)
        imgStorage.putData(imgData, metadata: nil) { (result, err) in
                
                if err == nil {
                    
                    imgStorage.downloadURL { (url, urlErr) in

                        if urlErr == nil {
                            completion(url?.absoluteString ?? "")
                        }else{
                            completion("")
                        }

                    }
                    
                }else{
                    completion("")
                }
                
        }
        
    }
    
}
