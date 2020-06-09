//
//  PhotoLibraryAuthorized.swift
//  InstagramClone
//
//  Created by Jean Paull on 14/05/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import Photos

struct PhotoLibraryAuthorized {
    
    func getAuthorizeStatus(_ viewController:UIViewController, completion:@escaping(_ authorized:Bool)->Void){
        
        let photos = PHPhotoLibrary.authorizationStatus()
        if photos == .notDetermined {
            PHPhotoLibrary.requestAuthorization({status in
                if status == .authorized{
                    completion(true)
                } else {
                    let alert = UIAlertController(title: "Photos Access Denied", message: "App needs access to photos library.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    viewController.present(alert, animated: true, completion: nil)
                    completion(false)
                }
            })
        } else if photos == .authorized {
            completion(true)
        }
    }
    
}
