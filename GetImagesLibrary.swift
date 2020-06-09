//
//  GetImagesLibrary.swift
//  InstagramClone
//
//  Created by Jean Paull on 14/05/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit
import Photos

struct GetImagesLibrary {
    
    func getimages(completion:@escaping(_ arrayImages:Array<UIImage>)->Void){
        
        var array = [UIImage]()
        
        DispatchQueue.main.async {
            
            let imgManager = PHImageManager.default()
            
            let requestOptions=PHImageRequestOptions()
            requestOptions.isSynchronous=true
            requestOptions.deliveryMode = .highQualityFormat
            
            let fetchOptions=PHFetchOptions()
            fetchOptions.sortDescriptors=[NSSortDescriptor(key:"creationDate", ascending: false)]
            
            let fetchResult: PHFetchResult = PHAsset.fetchAssets(with: .image, options: fetchOptions)
            
            if fetchResult.count > 0 {
                
                for i in 0..<fetchResult.count{
                    
                    imgManager.requestImage(for: fetchResult.object(at: i) as PHAsset, targetSize: CGSize(width:500, height: 500), contentMode: .aspectFill, options: requestOptions) { (image, nil) in
                        
                        if let img = image {
                            array.append(img)
                        }
                        
                    }
                    
                }
                
            }
            completion(array)
        }
        
    }
    
}
