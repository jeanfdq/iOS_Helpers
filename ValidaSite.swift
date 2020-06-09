//
//  ValidaSite.swift
//  Cars
//
//  Created by Jean Paull on 02/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class ValidaSite: NSObject {
    
    func validar(_ site:String) -> Bool {
        
        let siteRegex = "^(http:\\/\\/www\\.|https:\\/\\/www\\.|http:\\/\\/|https:\\/\\/)?[a-z0-9]+([\\-\\.]{1}[a-z0-9]+)*\\.[a-z]{2,5}(:[0-9]{1,5})?(\\/.*)?$"
        
        let siteText = NSPredicate(format: "SELF MATCHES[c] %@", siteRegex)
        
        return siteText.evaluate(with: site.trim())
    }

}
