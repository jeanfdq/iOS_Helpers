//
//  GetStatusBarSize.swift
//  TestClean
//
//  Created by Jean Paull on 22/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit


class GetStatusBarSize {
    // let mySceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    // guard let sceneDelegate = mySceneDelegate else {return .zero}
    // guard let window = sceneDelegate.window else {return .zero}
    // guard let size = window.windowScene?.statusBarManager?.statusBarFrame else {return .zero}
    // return size

    static func GetSize() -> CGRect {
        var size: CGRect = .zero
        if #available(iOS 13.0, *) {
            size = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame ?? CGRect.zero
        } else {
            size = UIApplication.shared.statusBarFrame
        }
        return size
    }
}
