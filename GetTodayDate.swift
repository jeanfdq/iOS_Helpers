//
//  GetTodayDate.swift
//  ToDo_CoreData
//
//  Created by Jean Paull on 10/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

class GetTodayDate: NSObject {

    //Current date
    let current = Date()
    
    func getSingleDateToString (_ pattern:String = "dd/MM/yyyy") -> String {
        
        let patternaDate = DateFormatter()
        patternaDate.dateFormat = pattern
        
        let todayDate = patternaDate.string(from: current)
        
        return todayDate
        
    }
    
    func getDateWithHourMinuteToString() -> String {
        
        let patternDate = DateFormatter()
        patternDate.dateFormat = "dd/MM/yyyy hh:mm"
        
        let todayDate = patternDate.string(from: current)
        
        return todayDate
        
    }
    
}
