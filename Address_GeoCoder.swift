//
//  Address_GeoCoder.swift
//  uber_clone
//
//  Created by Jean Paull on 15/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import MapKit

class Address_GeoCoder: NSObject {
    
    func GeoLocToAddress( _ lat:String, _ lon:String, completion:@escaping(_ address:[String:String]) -> Void) {
        
        var address:Dictionary<String,String> = [:]
        
        var center = CLLocationCoordinate2D()
        center.latitude  = Double(lat)!
        center.longitude = Double(lon)!
        let ceo = CLGeocoder()
        let loc = CLLocation(latitude: center.latitude, longitude: center.longitude)
        
        ceo.reverseGeocodeLocation(loc) { (placeMarks, err) in
            
            if err == nil {
                
                let pm = placeMarks! as [CLPlacemark]
                
                if pm.count > 0 {
                    
                    let pm = placeMarks![0]
                    
                 
                    address = ["country": (pm.country ?? "") as String, "city": (pm.locality ?? "") as String, "neighborhood": (pm.subLocality ?? "") as String , "street" : (pm.thoroughfare ?? "") as String, "number":(pm.subThoroughfare ?? "") as String , "postalcode":(pm.postalCode ?? "") as String]
                    
                    completion(address)
                
                    
                }
                
            }else{
                print("reverseGeocoder fail: \(String(describing: err?.localizedDescription))")
            }
            
        }
        
    }

}
