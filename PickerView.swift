//
//  PickerView.swift
//  InstagramClone
//
//  Created by Jean Paull on 21/04/20.
//  Copyright © 2020 Jean Paull. All rights reserved.
//

import UIKit

protocol getPhotoFromPickerViewProtocol {
    func getPhoto(_ imagePickerView:UIImage)
}

class PickerView: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var pickerViewDelegate:getPhotoFromPickerViewProtocol?
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {return}
        pickerViewDelegate?.getPhoto(image)
        
        picker.dismiss(animated: true, completion: nil)
    }

}
