//
//  GetSceneWindow.swift
//  Chat
//
//  Created by Jean Paull on 07/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

struct GetSceneWindow {
    
    static let shared = GetSceneWindow()
    
    func getWindow() -> UIWindow {
        
        let mySceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
        
        if let sceneDelegate = mySceneDelegate {
            
            guard let window = sceneDelegate.window else {return UIWindow()}
            return window

        }else{
            return UIWindow()
        }
        
    }
    
}
