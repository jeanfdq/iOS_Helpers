//
//  DeviceInfo.swift
//  InstagramClone
//
//  Created by Jean Paull on 14/05/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

struct DeviceInfo {
    struct Orientation {
        // indicate current device is in the LandScape orientation
        static var isLandscape: Bool {
            get {
                
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isLandscape
                    : UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isLandscape ?? true
            }
        }
        // indicate current device is in the Portrait orientation
        static var isPortrait: Bool {
            get {
                return UIDevice.current.orientation.isValidInterfaceOrientation
                    ? UIDevice.current.orientation.isPortrait
                    : UIApplication.shared.windows.first?.windowScene?.interfaceOrientation.isPortrait ?? true
            }
        }
    }
}
