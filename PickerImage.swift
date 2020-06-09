//
//  PickerImage.swift
//  Chat
//
//  Created by Jean Paull on 07/06/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit


protocol GetPictureDelegate {
    func getPicture(_ image:UIImage)
}

class PickerImage: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    static let shared = PickerImage()
    var getPictureDelegate:GetPictureDelegate?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        var selectedImageFromPicker:UIImage?
        
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            selectedImageFromPicker = editedImage
        }else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImageFromPicker = originalImage
        }
        
        if let img = selectedImageFromPicker {
            getPictureDelegate?.getPicture(img)
        }
        
        picker.dismiss(animated: true, completion: nil)
        
    }
    
}
