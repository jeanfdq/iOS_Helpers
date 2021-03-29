//
//  Authorize.swift
//  iOSChat
//
//  Created by Jean Paul Borges Manzini on 29/03/21.
//


import LocalAuthentication

class Authorize: NSObject {
    
    static func WithTouchOrFace(completion: @escaping (Bool)->Void) {
        
        let laContext = LAContext()
        var error: NSError?
        let biometricsPolicy = LAPolicy.deviceOwnerAuthenticationWithBiometrics
        
        if (laContext.canEvaluatePolicy(biometricsPolicy, error: &error)) {
            
            if let laError = error {
                print("laError - \(laError)")
                completion(false)
            }
            
            var localizedReason = "Unlock device"
            if #available(iOS 11.0, *) {
                if (laContext.biometryType == LABiometryType.faceID) {
                    localizedReason = "Unlock using Face ID"
                    print("FaceId support")
                } else if (laContext.biometryType == LABiometryType.touchID) {
                    localizedReason = "Unlock using Touch ID"
                    print("TouchId support")
                } else {
                    print("No Biometric support")
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            laContext.evaluatePolicy(biometricsPolicy, localizedReason: localizedReason, reply: { (isSuccess, error) in
                
                DispatchQueue.main.async(execute: {
                    
                    if let laError = error {
                        completion(false)
                        print("laError - \(laError)")
                    } else {
                        if isSuccess {
                            completion(true)
                            print("sucess")
                        } else {
                            completion(false)
                            print("failure")
                        }
                    }
                    
                })
            })
        }
        
    }
    
}
