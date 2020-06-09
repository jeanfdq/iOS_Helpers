//
//  GetSafeAreaSize.swift
//  Chat
//
//  Created by Jean Paull on 06/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

struct GetSafeAreaSize {
    
    static let shared = GetSafeAreaSize()
    
    func getSize() -> UIEdgeInsets {
        
        let mySceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        if let sceneDelegate = mySceneDelegate {
            
            guard let window = sceneDelegate.window else {return UIEdgeInsets.zero}
            
            return window.safeAreaInsets
            
            
        }else{
            return UIEdgeInsets.zero
        }
        
    }
    
}
