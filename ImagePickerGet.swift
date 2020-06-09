//
//  ImagePickerGet.swift
//  Cars
//
//  Created by Jean Paull on 04/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

protocol imagePickerDelegate {
    func getPicture(_ image:UIImage)
}

class ImagePickerGet: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    var imagePickerDelegate:imagePickerDelegate?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        let img = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        
        imagePickerDelegate?.getPicture(img)
        picker.dismiss(animated: true, completion: nil)
    }

    
    
}
