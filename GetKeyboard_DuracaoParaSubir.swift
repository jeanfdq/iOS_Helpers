//
//  GetKeyboard_DuracaoParaSubir.swift
//  Cars
//
//  Created by Jean Paull on 05/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class GetKeyboard_DuracaoParaSubir: NSObject {

    func getDUracao(_ notification:NSNotification) -> Double? {
        
        guard let keyboardDuracao = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double) else {return nil}
        return keyboardDuracao
        
    }
    
}
