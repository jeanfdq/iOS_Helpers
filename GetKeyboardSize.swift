//
//  GetKeyboardSize.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class GetKeyboardSize: NSObject {

    func getSize(_ notification:NSNotification) -> CGRect? {
        
        guard let keyboardsize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {return nil}
        
        return keyboardsize
        
    }
    
}
